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

w_weak <- social_weights(c(7, 3), theta = 0.5)
w_minority <- social_weights(c(7, 3), theta = -1)
check("theta=0.5 weakens but does not reverse the majority",
      w_weak[1] > 0.5 && w_weak[1] < w_prop[1],
      sprintf("(theta=0.5: p_majority = %.2f)", w_weak[1]))
check("negative theta favours the minority",
      w_minority[2] > 0.5,
      sprintf("(theta=-1: p_minority = %.2f)", w_minority[2]))

# ------------------------------------------------------------
# 3. In a difficult STABLE world, moderate copying should help
#    more agents find the slightly better option.
# ------------------------------------------------------------
set.seed(202604)
stable_individual <- average_performance(
  n_reps = 60, n_agents = 10, n_trials = 100,
  reward_probs = c(0.3, 0.5), alpha = 0.3, beta = 5,
  sigma = 0, theta = 2
)
stable_moderate <- average_performance(
  n_reps = 60, n_agents = 10, n_trials = 100,
  reward_probs = c(0.3, 0.5), alpha = 0.3, beta = 5,
  sigma = 0.3, theta = 2
)
stable_social <- average_performance(
  n_reps = 60, n_agents = 10, n_trials = 100,
  reward_probs = c(0.3, 0.5), alpha = 0.3, beta = 5,
  sigma = 0.6, theta = 2
)
late_individual <- mean(stable_individual$correct[81:100])
late_moderate <- mean(stable_moderate$correct[81:100])
late_social <- mean(stable_social$correct[81:100])
check("sigma=0.3 helps in the difficult 30% vs 50% world",
      late_moderate > late_individual + 0.03,
      sprintf("(sigma=0: %.2f, sigma=0.3: %.2f)",
              late_individual, late_moderate))
check("sigma=0.6 helps more in the difficult 30% vs 50% world",
      late_social > late_individual + 0.08,
      sprintf("(sigma=0: %.2f, sigma=0.6: %.2f)",
              late_individual, late_social))

# Heterogeneous parameter vectors should map to the correct agents.
heterogeneous <- simulate_group(
  n_agents = 4, n_trials = 10,
  alpha = c(0.1, 0.3, 0.5, 0.7),
  beta = c(2, 4, 6, 8),
  sigma = c(0.2, 0.4, 0.6, 0.8),
  theta = c(0.5, 1, 2, 4)
)
first_trials <- heterogeneous[heterogeneous$trial == 1, ]
check("group simulation accepts all four parameters per agent",
      identical(first_trials$alpha, c(0.1, 0.3, 0.5, 0.7)) &&
        identical(first_trials$beta, c(2, 4, 6, 8)) &&
        identical(first_trials$sigma, c(0.2, 0.4, 0.6, 0.8)) &&
        identical(first_trials$theta, c(0.5, 1, 2, 4)))

# ------------------------------------------------------------
# 4. Tutorial 5 settings: social learning helps before a change,
#    but strong social influence delays adaptation after it.
# ------------------------------------------------------------
set.seed(202605)
t5_sweep <- lapply(c(0, 0.3, 0.6, 0.7), function(s) {
  perf <- average_performance(
    n_reps = 80, n_agents = 10, n_trials = 150,
    reward_probs = c(0.5, 0.7), alpha = 0.7, beta = 5,
    sigma = s, theta = 4, change_point = 76)
  data.frame(sigma = s,
             before = mean(perf$correct[56:75]),
             early_after = mean(perf$correct[76:95]),
             late_after = mean(perf$correct[131:150]))
})
t5_sweep <- do.call(rbind, t5_sweep)

check("Tutorial 5 moderate copiers outperform before the change",
      t5_sweep$before[t5_sweep$sigma == 0.3] >
        t5_sweep$before[t5_sweep$sigma == 0] + 0.05,
      sprintf("(sigma=0: %.2f, sigma=0.3: %.2f)",
              t5_sweep$before[t5_sweep$sigma == 0],
              t5_sweep$before[t5_sweep$sigma == 0.3]))
check("Tutorial 5 strong social learners adapt slowly after the change",
      t5_sweep$early_after[t5_sweep$sigma == 0.7] <
        t5_sweep$early_after[t5_sweep$sigma == 0] - 0.15,
      sprintf("(sigma=0: %.2f, sigma=0.7: %.2f)",
              t5_sweep$early_after[t5_sweep$sigma == 0],
              t5_sweep$early_after[t5_sweep$sigma == 0.7]))
check("Tutorial 5 sigma=0.3 keeps a late advantage",
      t5_sweep$late_after[t5_sweep$sigma == 0.3] >
        t5_sweep$late_after[t5_sweep$sigma == 0] + 0.05,
      sprintf("(sigma=0: %.2f, sigma=0.3: %.2f)",
              t5_sweep$late_after[t5_sweep$sigma == 0],
              t5_sweep$late_after[t5_sweep$sigma == 0.3]))

# ------------------------------------------------------------
# 5. Group simulation in a CHANGING world:
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
# 6. Wisdom of crowds: averaging many noisy guesses beats
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
