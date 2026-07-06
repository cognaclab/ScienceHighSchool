# ============================================================
# verify_simulations.R
# Quick numerical checks that the tutorial models behave as
# the tutorials claim. Run from the repository root:
#   Rscript R/verify_simulations.R
# ============================================================

source("R/bandit_functions.R")
set.seed(2026)

ok <- TRUE
check <- function(label, condition, detail = "") {
  status <- if (condition) "PASS" else "FAIL"
  cat(sprintf("[%s] %s %s\n", status, label, detail))
  if (!condition) ok <<- FALSE
}

# ------------------------------------------------------------
# 1. A single learner should end up preferring the better option
# ------------------------------------------------------------
runs <- lapply(1:200, function(i) simulate_learner(n_trials = 100))
late_best <- mean(sapply(runs, function(d) mean(d$choice[81:100] == 2)))
check("individual learner prefers best arm late in learning",
      late_best > 0.8, sprintf("(p_best trials 81-100 = %.2f)", late_best))

early_best <- mean(sapply(runs, function(d) mean(d$choice[1:10] == 2)))
check("learning curve rises (late > early)",
      late_best > early_best + 0.15,
      sprintf("(early = %.2f, late = %.2f)", early_best, late_best))

# ------------------------------------------------------------
# 2. Social weights: conformity exaggerates the majority
# ------------------------------------------------------------
w_prop <- social_weights(c(7, 3), theta = 1)
w_conf <- social_weights(c(7, 3), theta = 3)
check("conformity (theta > 1) exaggerates the majority",
      w_conf[1] > w_prop[1],
      sprintf("(theta=1: %.2f, theta=3: %.2f)", w_prop[1], w_conf[1]))

# ------------------------------------------------------------
# 3. Group simulation in a CHANGING world:
#    strong copiers should get stuck on the old best option
#    ("madness of crowds"), individual learners recover.
# ------------------------------------------------------------
sweep <- lapply(c(0, 0.3, 0.6, 0.9), function(s) {
  perf <- average_performance(n_reps = 40,
                              n_agents = 10, n_trials = 150,
                              sigma = s, theta = 2,
                              reward_probs = c(0.3, 0.7),
                              change_point = 76)
  data.frame(sigma = s,
             before = mean(perf$correct[56:75]),    # settled, pre-change
             after  = mean(perf$correct[131:150]))  # long after the change
})
sweep <- do.call(rbind, sweep)
print(sweep, row.names = FALSE)

check("moderate copying does fine before the change",
      sweep$before[sweep$sigma == 0.3] > 0.75)
check("strong copiers recover WORSE after the change than individual learners",
      sweep$after[sweep$sigma == 0.9] < sweep$after[sweep$sigma == 0] - 0.1,
      sprintf("(sigma=0: %.2f, sigma=0.9: %.2f)",
              sweep$after[sweep$sigma == 0], sweep$after[sweep$sigma == 0.9]))

# ------------------------------------------------------------
# 4. Wisdom of crowds: averaging many noisy guesses beats
#    a typical individual guess
# ------------------------------------------------------------
truth <- 500
individual_error <- mean(abs(rnorm(10000, mean = truth * 0.95, sd = 120) - truth))
crowd_errors <- replicate(2000, abs(mean(rnorm(30, mean = truth * 0.95, sd = 120)) - truth))
check("a crowd of 30 beats the average individual",
      mean(crowd_errors) < individual_error,
      sprintf("(individual error = %.0f, crowd error = %.0f)",
              individual_error, mean(crowd_errors)))

cat(if (ok) "\nAll checks passed.\n" else "\nSOME CHECKS FAILED.\n")
if (!ok) quit(status = 1)
