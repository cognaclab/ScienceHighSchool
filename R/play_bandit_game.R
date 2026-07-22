# ============================================================
# play_bandit_game.R
# A slot-machine game YOU can play in the RStudio console.
#
# How to play:
#   1. Open this project in RStudio
#   2. In the console, run:
#        source("R/play_bandit_game.R")
#        play_game("Wataru")                    # solo version
#        play_game("Wataru", hints = TRUE)      # with social hints
#   3. Your results are saved in data/game_records/
#      so the whole group can analyse them later!
#
# The game: there are 3 slot machines. Each machine pays a coin
# with some hidden probability. You have 40 turns. Find the good
# machine and earn as many coins as you can!
#
# With hints = TRUE you also see which machine SAVED EARLIER GAMES
# chose most often on the same turn - real human social information.
# Do the hints help? That is a research question you can test!
# ============================================================

# --- Secret machine settings -- players, NO PEEKING below this line! ---

.game_probs <- function() {
  # probabilities for machines 1, 2, 3 (same for every player,
  # so everyone's data can be compared)
  c(0.35, 0.65, 0.45)
}

.records_dir <- "data/game_records"

.record_path <- function(player_name, hints = FALSE) {
  safe_name <- gsub("\\W", "", player_name)
  if (nchar(safe_name) == 0) stop("player_name must contain a letter or number")
  file.path(.records_dir,
            sprintf("%s_%s.csv", safe_name, if (hints) "social" else "solo"))
}

list_game_records <- function() {
  basename(list.files(.records_dir, pattern = "\\.csv$", full.names = TRUE))
}

delete_game_record <- function(player_name, hints = FALSE) {
  target <- .record_path(player_name, hints)
  if (!file.exists(target)) {
    cat("No record found at:", target, "\n")
    return(invisible(FALSE))
  }
  deleted <- file.remove(target)
  if (deleted) cat("Deleted:", target, "\n")
  invisible(deleted)
}

# Read all choices from saved earlier games for social hints
.earlier_choices <- function() {
  files <- list.files(.records_dir, pattern = "\\.csv$", full.names = TRUE)
  if (length(files) == 0) return(NULL)
  do.call(rbind, lapply(files, read.csv))
}

.ask_choice <- function(t, input_fun) {
  repeat {
    answer <- input_fun(sprintf("Turn %02d/40 - choose a machine (1, 2 or 3): ", t))
    if (answer %in% c("1", "2", "3")) return(as.integer(answer))
    cat("Please type 1, 2 or 3 and press Enter.\n")
  }
}

play_game <- function(player_name,
                      hints = FALSE,
                      n_trials = 40,
                      input_fun = readline) {
  stopifnot(is.character(player_name), nchar(player_name) > 0)
  probs <- .game_probs()
  earlier <- if (hints) .earlier_choices() else NULL

  cat("\n=======================================\n")
  cat("   THE SLOT MACHINE GAME\n")
  cat("=======================================\n")
  cat("3 machines. 40 turns. Some machines are\n")
  cat("luckier than others... good luck,", player_name, "!\n\n")

  choice <- integer(n_trials)
  reward <- integer(n_trials)
  hint_shown <- integer(n_trials)
  score <- 0

  for (t in 1:n_trials) {
    hint_shown[t] <- NA_integer_
    if (hints && !is.null(earlier)) {
      turn_data <- earlier$choice[earlier$trial == t]
      if (length(turn_data) > 0) {
        counts <- tabulate(turn_data, nbins = 3)
        hint_shown[t] <- which.max(counts)
        cat(sprintf("  HINT: saved earlier games most often chose machine %d here\n",
                    hint_shown[t]))
      }
    }
    choice[t] <- .ask_choice(t, input_fun)
    reward[t] <- rbinom(1, size = 1, prob = probs[choice[t]])
    score <- score + reward[t]
    cat(if (reward[t] == 1) "  >> COIN! " else "  >> nothing. ",
        sprintf("(score: %d)\n\n", score))
  }

  cat(sprintf("=== GAME OVER! Final score: %d / %d ===\n\n", score, n_trials))

  result <- data.frame(
    player = player_name,
    mode = if (hints) "social" else "solo",
    trial = 1:n_trials,
    choice = choice,
    reward = reward,
    hint = hint_shown
  )
  if (!dir.exists(.records_dir)) dir.create(.records_dir, recursive = TRUE)
  outfile <- .record_path(player_name, hints)
  write.csv(result, outfile, row.names = FALSE)
  cat("Your data was saved to:", outfile, "\n")
  cat("(Later we will compare your play with our learning models!)\n")
  invisible(result)
}

cat("Game loaded! Start playing with:  play_game(\"YourName\")\n")
