# ============================================================
# bandit_functions.R
# Core model code for the tutorials.
#
# Load these functions into your R session with:
#   source("R/bandit_functions.R")
# ============================================================


# ------------------------------------------------------------
# softmax(): turn value estimates into choice probabilities
#
#   values : a vector of value estimates (one per option)
#   beta   : how strongly the agent goes for the best option
#            beta = 0    -> choose completely at random
#            big beta    -> (almost) always choose the best-looking option
# ------------------------------------------------------------
softmax <- function(values, beta) {
  scores <- exp(beta * (values - max(values)))  # subtracting max keeps numbers stable
  scores / sum(scores)
}


# ------------------------------------------------------------
# simulate_learner(): ONE agent learning alone by trial and error
#
# The agent keeps a value estimate Q for each option.
# After each choice it updates:
#     Q <- Q + alpha * (reward - Q)
# This is called the Rescorla-Wagner rule (a simple form of
# reinforcement learning). (reward - Q) is the "prediction error":
# how surprised the agent is.
#
#   n_trials     : how many choices the agent makes
#   alpha        : learning rate, between 0 and 1
#   beta         : softmax exploration parameter (see above)
#   reward_probs : probability that each option pays 1 point
#
# Returns a data frame with one row per trial.
# ------------------------------------------------------------
simulate_learner <- function(n_trials = 100,
                             alpha = 0.3,
                             beta = 5,
                             reward_probs = c(0.3, 0.7)) {
  n_options <- length(reward_probs)
  Q <- rep(0, n_options)          # value estimates all start at 0
  choice <- integer(n_trials)
  reward <- integer(n_trials)

  for (t in 1:n_trials) {
    p <- softmax(Q, beta)                                  # 1. how likely is each option?
    choice[t] <- sample.int(n_options, size = 1, prob = p) # 2. pick one
    reward[t] <- rbinom(1, size = 1, prob = reward_probs[choice[t]])  # 3. world responds
    Q[choice[t]] <- Q[choice[t]] + alpha * (reward[t] - Q[choice[t]]) # 4. learn
  }

  data.frame(trial = 1:n_trials, choice = choice, reward = reward)
}


# ------------------------------------------------------------
# social_weights(): how attractive is each option, socially?
#
# Given how many group members chose each option last trial,
# return the probability of copying each option.
#
#   counts : vector, how many agents chose each option last trial
#   theta  : conformity exponent
#            theta = 1  -> copy in proportion to popularity
#            theta > 1  -> CONFORMITY: exaggerate the majority
#            theta < 1  -> weaken the majority (contrarian-ish)
#
# The small +0.1 means no option ever has exactly zero chance.
# ------------------------------------------------------------
social_weights <- function(counts, theta = 1) {
  w <- (counts + 0.1)^theta
  w / sum(w)
}


# ------------------------------------------------------------
# simulate_group(): MANY agents learning at the same time
#
# Each agent mixes two sources of information:
#   * individual: its own value estimates (softmax, as above)
#   * social:     what the group chose on the previous trial
#
#   p(choice) = (1 - sigma) * p_individual + sigma * p_social
#
#   sigma = 0 -> pure individual learner (ignores everyone)
#   sigma = 1 -> pure copier (never uses its own experience)
#
# alpha, beta, sigma, and theta may each be one number shared by all
# agents, or a vector with one value per agent (individual differences).
#
# The environment can change! If change_point = 75, then from
# trial 75 the reward probabilities switch to reward_probs_after.
# (Use change_point = NA for a stable world.)
#
# Returns a long data frame: one row per agent per trial,
# with a column `best` marking the option that is CURRENTLY best.
# ------------------------------------------------------------
simulate_group <- function(n_agents = 10,
                           n_trials = 100,
                           alpha = 0.3,
                           beta = 5,
                           sigma = 0.3,
                           theta = 2,
                           reward_probs = c(0.3, 0.7),
                           change_point = NA,
                           reward_probs_after = rev(reward_probs)) {
  n_options <- length(reward_probs)
  if (length(alpha) == 1) alpha <- rep(alpha, n_agents)
  if (length(beta) == 1) beta <- rep(beta, n_agents)
  if (length(sigma) == 1) sigma <- rep(sigma, n_agents)
  if (length(theta) == 1) theta <- rep(theta, n_agents)
  if (any(c(length(alpha), length(beta), length(sigma), length(theta)) != n_agents)) {
    stop("alpha, beta, sigma, and theta must each have length 1 or n_agents")
  }
  Q <- matrix(0, nrow = n_agents, ncol = n_options)
  choice <- matrix(NA_integer_, nrow = n_trials, ncol = n_agents)
  reward <- matrix(NA_integer_, nrow = n_trials, ncol = n_agents)
  best <- integer(n_trials)

  probs_now <- reward_probs
  for (t in 1:n_trials) {
    if (!is.na(change_point) && t >= change_point) probs_now <- reward_probs_after
    best[t] <- which.max(probs_now)

    # social information = what everyone chose on the previous trial
    if (t == 1) {
      counts <- NULL  # no social information yet
    } else {
      counts <- tabulate(choice[t - 1, ], nbins = n_options)
    }

    for (i in 1:n_agents) {
      p_social <- if (t == 1) rep(1 / n_options, n_options) else
        social_weights(counts, theta[i])
      p_individual <- softmax(Q[i, ], beta[i])
      p <- (1 - sigma[i]) * p_individual + sigma[i] * p_social
      ch <- sample.int(n_options, size = 1, prob = p)
      rw <- rbinom(1, size = 1, prob = probs_now[ch])
      Q[i, ch] <- Q[i, ch] + alpha[i] * (rw - Q[i, ch])
      choice[t, i] <- ch
      reward[t, i] <- rw
    }
  }

  data.frame(
    trial  = rep(1:n_trials, times = n_agents),
    agent  = rep(1:n_agents, each = n_trials),
    choice = as.vector(choice),
    reward = as.vector(reward),
    best   = rep(best, times = n_agents),
    alpha  = rep(alpha, each = n_trials),
    beta   = rep(beta, each = n_trials),
    sigma  = rep(sigma, each = n_trials),
    theta  = rep(theta, each = n_trials)
  )
}


# ------------------------------------------------------------
# performance_curve(): summarise a group simulation
#
# For each trial, what fraction of agents chose the option
# that was best at that moment?
# ------------------------------------------------------------
performance_curve <- function(sim) {
  aggregate(correct ~ trial,
            data = transform(sim, correct = as.numeric(choice == best)),
            FUN = mean)
}


# ------------------------------------------------------------
# average_performance(): repeat a group simulation many times
# and average the performance curves (smoother = easier to read).
#
# Extra arguments (...) are passed straight to simulate_group().
# ------------------------------------------------------------
average_performance <- function(n_reps = 20, ...) {
  curves <- lapply(1:n_reps, function(rep) performance_curve(simulate_group(...)))
  trials <- curves[[1]]$trial
  mat <- sapply(curves, function(cu) cu$correct)
  data.frame(trial = trials, correct = rowMeans(mat))
}
