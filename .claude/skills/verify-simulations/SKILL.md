---
name: verify-simulations
description: Add or maintain numerical checks that back every qualitative claim made about simulation models. Use whenever model code (R/bandit_functions.R or similar) changes, or when a tutorial/slide/paper states a new claim about model behaviour.
---

# Verifying simulation claims

Principle: **every qualitative claim in a tutorial, slide deck, or manuscript
must be backed by a numerical check** in a verification script
(`R/verify_simulations.R` in this repo). "The learning curve rises",
"conformists herd after a change point" — if the text says it, a check
asserts it. This catches both broken code and broken claims.

## The pattern

```r
source("R/bandit_functions.R")
set.seed(2026)                       # fixed seed: checks must be deterministic

ok <- TRUE
check <- function(label, condition, detail = "") {
  status <- if (condition) "PASS" else "FAIL"
  cat(sprintf("[%s] %s %s\n", status, label, detail))
  if (!condition) ok <<- FALSE
}

# ... checks ...

cat(if (ok) "\nAll checks passed.\n" else "\nSOME CHECKS FAILED.\n")
if (!ok) quit(status = 1)            # non-zero exit so scripts/CI notice
```

## Writing good checks for stochastic models

- **Average enough replications that the effect is far from the threshold.**
  A check that passes at 0.51 vs a 0.50 threshold is a coin flip; aim for
  the true value to clear the threshold by several times the simulation's
  standard error (increase `n_reps` until it does).
- Check **directions and orderings**, not exact values: `late > early + 0.15`,
  `after_change[copiers] < after_change[individuals] - 0.1`.
- Always **print the numbers** in `detail` — a failing check should be
  diagnosable from its output alone.
- One check per claim, phrased in the claim's own words
  ("strong copiers recover WORSE after the change").
- Keep total runtime under ~1 minute so it actually gets run.

## Workflow

1. Model code changed → run `Rscript R/verify_simulations.R` before anything else.
2. New claim added to teaching/paper text → add a check first, watch it pass.
3. A check fails after a code change → decide explicitly: is the code wrong,
   or was the claim wrong? Update whichever it is — never delete a check to
   make the run green.
4. If a check flakes across seeds, it is underpowered: raise `n_reps` or
   widen the margin, don't re-roll the seed until it passes.
