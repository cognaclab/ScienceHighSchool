---
name: param-recovery
description: Research workflow for fitting computational models (RL, social learning) to behavioural data — parameter recovery and model recovery BEFORE touching real data. Use when fitting models to human/animal choice data, comparing candidate models, or reviewing model-fitting code.
---

# Model fitting done honestly: recover before you fit

Before fitting any cognitive model to real data, demonstrate on simulated
data that the fitting pipeline can (a) recover known parameters and
(b) distinguish the candidate models. Skipping this is the most common way
computational-modelling papers go wrong.

## Step 1 — Likelihood function

Write the negative log-likelihood of one participant's choices under the
model. For the RL/softmax agent used in this repo:

```r
source("R/bandit_functions.R")

nll_rl <- function(par, choice, reward, n_options = 2) {
  alpha <- plogis(par[1])   # transform: unconstrained -> (0, 1)
  beta  <- exp(par[2])      # transform: unconstrained -> (0, Inf)
  Q <- rep(0, n_options); nll <- 0
  for (t in seq_along(choice)) {
    p <- softmax(Q, beta)
    nll <- nll - log(p[choice[t]])
    Q[choice[t]] <- Q[choice[t]] + alpha * (reward[t] - Q[choice[t]])
  }
  nll
}
```

Fit on the *transformed* scale (no bounds needed) with **multiple random
restarts** — RL likelihoods are multimodal:

```r
fit_one <- function(choice, reward, n_restarts = 10) {
  fits <- lapply(1:n_restarts, function(i)
    optim(rnorm(2), nll_rl, choice = choice, reward = reward))
  best <- fits[[which.min(sapply(fits, `[[`, "value"))]]
  c(alpha = plogis(best$par[1]), beta = exp(best$par[2]), nll = best$value)
}
```

## Step 2 — Parameter recovery

Simulate agents on a grid of plausible true parameters, fit each simulated
dataset, then plot recovered vs true (one panel per parameter):

- Good recovery: points hug the identity line; report the correlation.
- Poor recovery for some region (e.g. high beta with few trials) is a
  *finding*: it bounds what you may claim about real participants there.
- Match the simulation to the real design exactly: same number of trials,
  options, reward schedule.

## Step 3 — Model recovery (when comparing models)

Simulate from each candidate model; fit all candidates to every dataset;
compare with AIC/BIC per dataset. Report the confusion matrix
(generating model × winning model). If models are not distinguishable in
simulation, model comparison on real data is meaningless — redesign first.

## Step 4 — Only now, real data

- Fit each participant separately first; look at raw fits before pooling.
- Sanity-check with simulation: generate data from the *fitted* parameters
  and confirm it reproduces the key behavioural patterns
  ("posterior predictive check", even for MLE fits).
- For hierarchical/Bayesian versions, move to Stan via `cmdstanr` — keep
  this MLE pipeline as the fast cross-check.

## Reporting checklist

- [ ] Recovery plots (true vs recovered) in supplement
- [ ] Model-recovery confusion matrix, if models are compared
- [ ] Number of restarts / sampler diagnostics stated
- [ ] Simulated-from-fit behaviour compared against real behaviour
