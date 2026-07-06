# Teaching Notes (instructors only)

Practical notes for running the course at the RIKEN Wako Science Camp,
July 27–30, 2026. Camp logistics (hotel transfers, overnight supervision)
are handled by the Wako administration team (contact: Kawano-san).

## The constraints that shape this course

- 4 students, first-year high school (~15–16 y.o.), likely little/no
  programming experience, motivated enough to apply for an English course
- **Day 1 (Mon 7/27)** is orientation, run by RIKEN staff — our course
  effectively starts Day 2
- **Day 2 (Tue 7/28):** Wataru on site; full teaching day
- **Day 3 (Wed 7/29):** Wataru travelling (remote if possible); lab members
  lead. Evening at the hotel = students build presentation slides
- **Day 4 (Thu 7/30):** AM presentation practice; PM final presentation
  in front of the RIKEN president and directors — 10 min talk + 5 min Q&A
- Expectation from the organisers: **not** big scientific results.
  Friendship, fun, good memories, "I want to come back to RIKEN as a
  researcher." The presentation traditionally includes camp-life photos.

## Suggested timetable

### Before the camp
- Email students `setup/setup_guide.md`; ask for the "blue histogram
  screenshot" as homework — this surfaces installation problems early
- Backup for broken laptops/blocked installs: create free
  [Posit Cloud](https://posit.cloud) workspaces with this repo pre-loaded
- Optional (Kawano-san's idea, works well): ask students to run a small
  **guessing game at school** before the camp (e.g. "how many candies in
  this jar?" — collect ~30 guesses on paper). This becomes *their own*
  wisdom-of-crowds dataset for Tutorial 5 / the presentation

### Day 1 evening (if there is any slot at all)
- Meet the students, fix broken installs, `setup/test_setup.R` on every laptop
- Nothing else — they will be tired

### Day 2 (the big teaching day)
| Time | What | Materials |
|---|---|---|
| 09:00 | Lecture: Simulating Societies (~40 min + questions) | `slides/day2_am_models_and_agents.qmd` |
| 10:00 | Hands-on: R basics | `tutorials/01_welcome_to_r.qmd` |
| 11:00 | Hands-on: toy worlds, Monte Carlo, random walks | `tutorials/02_simulating_randomness.qmd` |
| 13:30 | Lecture: An Agent That Learns (~30 min) | `slides/day2_pm_learning_agents.qmd` |
| 14:15 | Hands-on: build the learning agent | `tutorials/03_learning_agents.qmd` |
| 16:00 | **Play the slot-machine game** (solo mode) — energiser! | `R/play_bandit_game.R` |
| 16:30 | Preview of tomorrow + Q&A | — |

### Day 3
| Time | What | Materials |
|---|---|---|
| 09:00 | Lecture: Wisdom & Madness of Crowds (~40 min) | `slides/day3_wisdom_and_madness.qmd` |
| 10:00 | Hands-on: social learning + collective behaviour | `tutorials/04_social_learning.qmd`, `05_collective_behaviour.qmd` |
| 11:30 | Play the game again (social-hints mode); look at the group's data | `R/play_bandit_game.R` |
| 13:30 | **Mini projects**: choose, predict, simulate | `project/mini_project_menu.md` |
| 16:00 | Freeze results: **export every figure to `figs/` as PNG** (see below) |
| evening (hotel) | Slide building — no R needed if figures are exported | template or PowerPoint |

### Day 4
- AM: two full rehearsals; time them strictly (10 min); prepare 2–3 likely
  Q&A questions per student *in English and Japanese*
- PM: presentation. Breathe.

## Pacing advice

- **Tutorials 1–2 are the risk zone.** If students have zero experience,
  budget the whole morning. Tutorials 4–5 can be compressed (run the code
  together on the projector) — the *ideas* matter more than typing speed.
- Every tutorial has "Try it!" boxes — these are buffers. Skip or assign
  selectively to faster/slower students.
- The single most important outcome of Day 2 AM: every student has
  personally made a plot appear. Celebrate it.
- Non-negotiable core if time collapses: Tutorial 3 (learning agent) +
  the σ-sweep figure in Tutorial 5. That is the whole story.

## Common pitfalls

- **Working directory errors** (`cannot open file 'R/bandit_functions.R'`):
  they didn't open the `.Rproj`. Fix: File → Open Project.
- **Smart quotes**: if students type code into LINE/Word first, `"` becomes
  `"` and breaks. Keep them in RStudio.
- **Japanese input mode**: a full-width space（　）inside code is invisible
  and fatal. If an error makes no sense, retype the line in half-width.
- **The game saves data** into `data/game_records/` — players must use
  different names or files overwrite.
- Render button asks to install packages (rmarkdown/knitr): allow it, or
  have students read tutorials in the browser from pre-rendered HTML you
  bring on a USB stick.

## Exporting figures for the hotel evening

Before students leave the lab on Day 3, make sure their key figures exist as
files (the hotel has no guaranteed dev environment):

```r
ggsave("figs/my_result.png", width = 8, height = 5, dpi = 200)
```

PowerPoint/Google Slides + PNG figures is a perfectly fine fallback for the
final talk — the Quarto template (`slides/final_presentation_template.qmd`)
is offered, not required.

## English support

- Slides and tutorials carry Japanese glosses for technical terms; speak
  slowly, write keywords on the whiteboard
- Let students discuss in Japanese in pairs, then report in English —
  quality of thought first, language second
- For the Q&A: rehearse "Could you say that again more slowly, please?" —
  it always gets a smile from the executives

## Going deeper / origins of these materials

- [COSMOS Summer School](https://cosmossummerschool.github.io/) — the
  university-level version of this course (Toyokawa & Wu); point keen
  students there
- Toyokawa, Whalen & Laland (2019). *Social learning strategies regulate the
  wisdom and madness of interactive crowds.* Nature Human Behaviour —
  the study Tutorial 5 reproduces in miniature
- Rescorla & Wagner (1972); Sutton & Barto, *Reinforcement Learning* —
  for instructors who want the deep background

## Repo hygiene

- `notes/` is **git-ignored** (contains internal email correspondence) —
  keep it that way if the repo is ever published
- `data/game_records/` will contain student names — anonymise or delete
  before any public release
- Run `Rscript R/verify_simulations.R` after any change to the model code
