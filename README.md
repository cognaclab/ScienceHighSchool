# Simulating Societies 🐟🐜🧑‍🤝‍🧑

**Tutorial materials for the RIKEN Wako Science Camp 2026**
*Computational Collective Dynamics Unit, RIKEN Center for Brain Science*

A 3-day crash course for high-school students on **agent-based modelling of
social learning and collective behaviour**, taught in English, using R.
Students build learning agents from scratch, let them copy each other, discover
the *wisdom and madness of crowds*, run a mini research project — and present
it to RIKEN's president and directors.

- **When:** July 27–30, 2026 (teaching days: July 28–29)
- **Who:** 4 first-year high-school students (no programming experience assumed)
- **Language:** English (with Japanese word lists for key terms)

## Quick start (students)

1. Follow [`setup/setup_guide.md`](setup/setup_guide.md) — install R and RStudio **before the camp**
2. Open `ScienceHighSchool.Rproj` in RStudio (this makes all file paths work)
3. Open `tutorials/01_welcome_to_r.qmd` and press **Render** — or just read along
   and type the code into the console

## What's where

| Folder | Contents |
|---|---|
| [`tutorials/`](tutorials/) | Five hands-on tutorials (Quarto), the core of the course |
| [`slides/`](slides/) | Lecture slide decks + the students' final-presentation template |
| [`R/`](R/) | Clean model code (`bandit_functions.R`), the playable slot-machine game, verification script |
| [`project/`](project/) | Mini-project menu for the final presentation |
| [`setup/`](setup/) | Installation guide + `test_setup.R` |
| [`data/`](data/) | Game records from the students (created during the camp) |
| [`instructor/`](instructor/) | Teaching notes: schedule, pacing, pitfalls, backup plans |

## The curriculum at a glance

| # | Tutorial | Key idea | Camp slot |
|---|---|---|---|
| 1 | Welcome to R | variables, vectors, randomness | pre-camp / Day 2 AM |
| 2 | Building Toy Worlds | models, Monte Carlo, random walks | Day 2 AM |
| 3 | An Agent That Learns | bandits, prediction error, explore–exploit | Day 2 PM |
| 4 | Learning From Others | social learning strategies, conformity | Day 3 AM |
| 5 | Wisdom & Madness of Crowds | collective intelligence, herding | Day 3 AM |
| — | Mini project + presentation | doing science | Day 3 PM → Day 4 |

The scientific through-line: **simple individual rules → rich collective
outcomes**. The capstone model reproduces the main result of
Toyokawa, Whalen & Laland (2019, *Nature Human Behaviour*): moderate social
learning produces collective wisdom, excessive conformity produces herding.

## Verifying the code

All simulation code is tested by:

```bash
Rscript R/verify_simulations.R
```

## Credits & related materials

These materials are a high-school-level adaptation of ideas taught at the
[COSMOS Summer School](https://cosmossummerschool.github.io/) (Computational
Summer school on Modeling Social and collective behavior), co-organised with
Charley Wu (University of Tübingen). COSMOS teaching notebooks are publicly
available on the COSMOS website and are the recommended next step for
students who want to go deeper.

<!-- TODO before making this repo public:
     - choose a license (CC BY 4.0 for docs + MIT for code is a common combo)
     - remove/keep the notes/ folder (it is git-ignored; contains internal email) -->
