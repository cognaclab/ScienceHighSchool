# Mini-Project Menu 🔬

Pick **one** question (or invent your own — often the best choice!).
You have Day 3 afternoon to run simulations and make figures, the evening
for slides, and you present on Day 4: **10 minutes + 5 minutes of questions**.

Every project uses the tools you already have: `simulate_group()`,
`average_performance()` (in `R/bandit_functions.R`), and ggplot.
A project = **question → prediction → simulation → figure → interpretation**.

---

## Project A: The best amount of copying ★☆☆

**Question:** How much should you rely on others (σ), if the world sometimes
changes?

**How:** Sweep `sigma = 0, 0.2, 0.4, 0.6, 0.8, 1.0` with
`change_point = 76`. Measure average performance before vs after the change.
Plot performance-after-change as a function of σ.

**Twist for extra depth:** does the answer depend on conformity strength θ?

---

## Project B: Big groups, smart groups? ★☆☆

**Question:** Is a group of 50 wiser than a group of 5 — or just better at
herding?

**How:** Fix `sigma = 0.6, theta = 2`; sweep `n_agents = 3, 5, 10, 20, 50`
in a changing world. Plot recovery speed after the change vs group size.

**Real-world link:** small village vs social media with millions of users.

---

## Project C: Conformity on trial ★★☆

**Question:** Is following the majority *more than proportionally* (θ > 1)
ever a good idea?

**How:** Fix σ = 0.5. Sweep `theta = 0.5, 1, 2, 4` in (a) a stable world and
(b) a changing world. Two curves per world; where does conformity win?

**Real-world link:** why might evolution have given fish, bees, and humans
conformist instincts?

---

## Project D: We are the data! ★★☆

**Question:** Do real humans (you four!) learn like the model — and do social
hints help?

**How:**

1. Everyone plays `play_game("Name")` solo, then `play_game("Name", hints = TRUE)`
2. Load all files from `data/game_records/` and plot the human learning curves
3. Simulate model agents with different α and β — which parameters look most
   like each of you? Who is the "high-α" player? Who explored most?
4. Compare solo vs hints scores across the group

**Warning:** n = 4 is tiny — that is itself a finding worth discussing!
(How many players *would* you need? Simulation can answer that too...)

---

## Project E: The restless world ★★★

**Question:** If the environment keeps changing, is *any* copying worth it?

**How:** Modify `simulate_group()` so the reward probabilities swap every
`k` trials (ask an instructor for hints — it is a ~3-line change). Sweep σ
for `k = 25, 50, 100`. Plot the best σ as a function of how restless the
world is.

**Real-world link:** fashion vs proverbs — fast-changing vs slow-changing
knowledge.

---

## Project F: Design your own ★?？

Some seeds:

- What if only ONE agent explores and everyone else copies (an "influencer" society)?
- What if agents copy only their *neighbour* (agents in a circle), not everyone?
- What if observing others sometimes gives WRONG information (rumours)?

Talk to an instructor before starting — we will help you scope it to one
afternoon.

---

## Checklist for a great presentation

- [ ] Our question in one sentence
- [ ] The model explained like a game (choices, rewards, copying rule)
- [ ] Our prediction — made BEFORE running the simulation
- [ ] 1–2 figures with labelled axes (this is where the time goes — start early!)
- [ ] What we found, in plain words
- [ ] One connection to real life
- [ ] One thing we would do next
- [ ] One fun slide about camp life 📸

Template: `slides/final_presentation_template.qmd`
