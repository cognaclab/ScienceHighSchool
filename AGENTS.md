# Project context

Teaching repo for the RIKEN Wako Science Camp (July 27–30, 2026): a 3-day
English-language course on agent-based modelling of social learning and
collective behaviour in R, for four first-year Japanese high-school students.
Adapted from the COSMOS summer school (Toyokawa & Wu). The capstone
reproduces Toyokawa, Whalen & Laland (2019, *Nat Hum Behav*): moderate social
learning → collective wisdom; strong conformity + changing environment → herding.

## Layout

- `tutorials/` — five Quarto tutorials (the course core), sequential
- `slides/` — revealjs lecture decks + students' final-presentation template
- `R/bandit_functions.R` — canonical model code (RL bandit + σ/θ social learning)
- `R/verify_simulations.R` — numerical checks for every claim the materials make
- `R/play_bandit_game.R` — interactive console game; data → `data/game_records/`
- `project/`, `setup/`, `instructor/` — mini-project menu, install guide, teaching notes
- `notes/` — private correspondence, git-ignored, never commit or quote publicly

## Commands

- Verify model code: `Rscript R/verify_simulations.R` (must pass before committing model changes)
- Render all docs: `PATH="/Applications/RStudio.app/Contents/Resources/app/quarto/bin:$PATH" quarto render`
  (quarto is not on PATH; use RStudio's bundled copy)

## Rules

- Tutorial/slide style, audience calibration: follow `.claude/skills/tutorial-writing/SKILL.md`
- Any model-code change: follow `.claude/skills/verify-simulations/SKILL.md`;
  keep tutorial 3's inline function copies in sync with `R/bandit_functions.R`
- Fitting models to behavioural data: follow `.claude/skills/param-recovery/SKILL.md`
- Helping a student debug: follow `.claude/skills/student-helper/SKILL.md`
- Student-facing text: simple English, Japanese glosses for key terms;
  code: base R + ggplot2 only, no tidyverse verbs
- `data/game_records/` contains student names — never commit or publish

## Note for agents without a skill system (e.g. Codex)

The `.claude/skills/*/SKILL.md` files above are plain markdown playbooks.
Before starting a matching task, read the relevant file and follow it:

| Task | Playbook |
|---|---|
| write/edit tutorials or slides | `.claude/skills/tutorial-writing/SKILL.md` |
| change simulation/model code | `.claude/skills/verify-simulations/SKILL.md` |
| fit models to behavioural data | `.claude/skills/param-recovery/SKILL.md` |
| help a student with an error | `.claude/skills/student-helper/SKILL.md` |
