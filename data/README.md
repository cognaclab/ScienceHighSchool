# data/

Data collected during the camp lives here.

- `game_records/` — created automatically when someone plays
  `R/play_bandit_game.R`. One CSV per player per mode
  (`<name>_solo.csv`, `<name>_social.csv`) with columns:
  `player, mode, trial, choice, reward, hint_1, hint_2, hint_3`.

- If students bring a pre-camp dataset (e.g. the school guessing game for
  the wisdom-of-crowds demo), put it here as a CSV too, e.g.
  `school_guesses.csv` with one column `guess`.

**Privacy note:** files here may contain student names. This folder is
git-ignored by default — review before sharing or publishing anything.
