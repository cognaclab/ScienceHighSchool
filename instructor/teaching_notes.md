# Teaching Notes (instructors only)

Practical notes for running the course at the RIKEN Wako Science Camp,
July 27–30, 2026. Camp logistics (hotel transfers, overnight supervision)
are handled by the Wako administration team (contact: Kawano-san).

## The constraints that shape this course

- 4 students, first-year high school (~15–16 y.o.), likely little/no
  programming experience, motivated enough to apply for an English course
- **Day 1 (Mon 7/27) has ZERO course-specific time.** Check-in 15:15–15:30
  (RIKEN Wako, 本部棟正面玄関, via 西門), self-introductions 15:30–16:10,
  then joint tours (RIKEN Gallery, Brain Box, quantum computer "叡")
  16:20–18:00, dinner ~18:15, hotel. Nothing before Day 2 is ours to teach
  in — see "Official schedule" below
- **Day 2 (Tue 7/28):** Wataru on site; our course block is **09:00–17:20**
  (lunch included), hard stop — a joint HOKUSAI facility tour starts 17:30
- **Day 3 (Wed 7/29):** Wataru travelling (remote if possible); lab members
  lead. Course block is again **09:00–17:20** hard stop — then a joint
  dinner with researchers, 17:30–19:00, all 3 courses together, not
  optional. Students return to the hotel ~19:00+, so the evening is short:
  front-load slide-building into the last hour of the day block, don't
  rely on the hotel
- **Day 4 (Thu 7/30):** our course block is **09:00–15:00** (lunch
  included) — final rehearsal and finishing touches only, no new content.
  Presentations are 15:40–17:30, joint with courses A and C, in front of
  the RIKEN president and directors — 10 min talk + 5 min Q&A, timing set
  by the organisers (no running over). Closing ceremony and dismissal
  follow, 17:30
- Expectation from the organisers: **not** big scientific results.
  Friendship, fun, good memories, "I want to come back to RIKEN as a
  researcher." The presentation traditionally includes camp-life photos.

## Official schedule (from the participant guide / しおり)

Ground truth from the 2026 participant guide — the organisers' fixed
times. Everything in "Suggested timetable" below must fit inside these
blocks.

| Day | Course time (ours) | Joint / fixed events |
|---|---|---|
| 1 — Mon 7/27 | *none* | 15:15 check-in → 16:10 self-intros → 16:20–18:00 tours (Gallery, Brain Box, quantum computer "叡") → 18:15 dinner → hotel |
| 2 — Tue 7/28 | **09:00–17:20** (incl. lunch) | 17:30–18:30 HOKUSAI facility tour (joint) → dinner → hotel |
| 3 — Wed 7/29 | **09:00–17:20** (incl. lunch) | 17:30–19:00 dinner with researchers, all 3 courses together (joint, mandatory) → hotel |
| 4 — Thu 7/30 | **09:00–15:00** (incl. lunch) | 15:40–17:30 joint presentations (all courses) + closing ceremony → 17:30 dismissal |

Other logistics worth knowing:
- Hotel: 東横イン和光市駅前 (1 person/room). Camp emergency line: 050-3502-2377
- Meeting point every morning: 本部棟正面玄関 (main HQ building entrance), via 西門
- Three parallel courses share the joint events above: **A** molecular
  life-control (Hagiwara team), **B** — ours — computational collective
  dynamics, **C** ultrafast laser science (Lin team)
- One course laptop is provided for slide-building; students may also
  bring their own (guest Wi-Fi is available)
- Students must phone their parents at Day 1 check-in and Day 4 dismissal
  — not our job, but worth a reminder if a student looks like they'll forget

## Suggested timetable

### Before the camp
- Email students `setup/setup_guide.md`; ask for the "blue histogram
  screenshot" as homework — this surfaces installation problems early.
  This matters even more now that Day 1 has no course slot at all: a
  broken laptop discovered on Day 1 stays broken until Day 2 morning
- Backup for broken laptops/blocked installs: create free
  [Posit Cloud](https://posit.cloud) workspaces with this repo pre-loaded
- Optional (Kawano-san's idea, works well): ask students to run a small
  **guessing game at school** before the camp (e.g. "how many candies in
  this jar?" — collect ~30 guesses on paper). This becomes *their own*
  wisdom-of-crowds dataset for Tutorial 5 / the presentation

### Day 1
Nothing to teach — see the schedule above. If a laptop is still broken,
fix it informally after dinner at the hotel, or first thing Day 2 — there
is no scheduled slot and no guarantee an instructor is even present
(Wataru is off-site Day 1; confirm lab coverage in advance).

### Day 2 (the big teaching day) — course block 09:00–17:20, hard stop
| Time | What | Materials |
|---|---|---|
| 09:00 | Lecture: Simulating Societies (~40 min + questions) | `slides/day2_am_models_and_agents.qmd` |
| 09:45 | Hands-on: R basics | `tutorials/01_welcome_to_r_notebook.Rmd` |
| 10:45 | Hands-on: toy worlds, Monte Carlo, random walks | `tutorials/02_simulating_randomness_notebook.Rmd` |
| 12:00 | Lunch (inside our block — schedule it yourselves) | — |
| 13:00 | Lecture: An Agent That Learns (~30 min) | `slides/day2_pm_learning_agents.qmd` |
| 13:45 | Hands-on: build the learning agent | `tutorials/03_learning_agents_notebook.Rmd` |
| 15:45 | **Play the slot-machine game** (solo mode) — energiser! | `R/play_bandit_game.R` |
| 16:15 | Preview of tomorrow + Q&A | — |
| 17:15 | **Wrap up — hard stop.** HOKUSAI tour starts 17:30, joint with the other courses | — |

### Day 3 — course block 09:00–17:20, hard stop
| Time | What | Materials |
|---|---|---|
| 09:00 | Lecture: Wisdom & Madness of Crowds (~40 min) | `slides/day3_wisdom_and_madness.qmd` |
| 10:00 | Hands-on: social learning + collective behaviour | `tutorials/04_social_learning_notebook.Rmd`, `05_collective_behaviour_notebook.Rmd` |
| 11:30 | Play the game again (social-hints mode); look at the group's data | `R/play_bandit_game.R` |
| 12:15 | Lunch | — |
| 13:15 | **Mini projects**: choose, predict, simulate | `project/mini_project_menu.md` |
| 15:45 | Freeze results: **export every figure to `figs/` as PNG** (see below) | — |
| 16:15 | Start the slides now, on-site — don't wait for the hotel | template or PowerPoint |
| 17:15 | **Wrap up — hard stop.** Joint dinner with researchers 17:30–19:00 | — |
| hotel, ~19:15+ | Light polishing only — everyone will be tired and it's late | — |

### Day 4 — course block 09:00–15:00 only, then joint presentations at 15:40

This block is rehearsal and finishing touches, not new content.
Presentations run 15:40–17:30, joint with courses A and C; the order and
per-course timing is set by the organisers, so there is no buffer to run
over.

- 09:00: finish slides — hard internal deadline, no later than 11:00
- 11:00–14:30: two to three full rehearsals, timed strictly (10 min talk);
  prepare 2–3 likely Q&A questions per student, in English **and** Japanese
- 14:30: walk to the presentation venue, settle in
- 15:40 onward: presentation. Breathe.

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
- **Hard stops matter**: the HOKUSAI tour (Day 2) and the researcher
  dinner (Day 3) start punctually and are joint with the other two
  courses — finish 5–10 minutes before 17:20 every day, don't let a demo
  or a good question run long.
- Notebook asks to install packages (rmarkdown/knitr): allow it, or have
  students read tutorials in the browser from pre-rendered HTML you bring on
  a USB stick.

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
