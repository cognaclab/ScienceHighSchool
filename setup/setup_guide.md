# Setup Guide — do this BEFORE the camp! 🛠️

（キャンプが始まる前に、おうちのパソコンでこの準備をしてきてください）

You need a laptop with two free programs: **R** (the engine) and
**RStudio** (the friendly cockpit). Installation takes about 15 minutes.
If anything fails, don't worry — email us before the camp if you can. Day 1
has no class time at all, so if something is still broken when you arrive,
we'll fix it together first thing on Day 2 morning.

Before the camp:

- **Required（必須）:** Complete Steps 1–5. Make sure the blue histogram appears.
- **Strongly recommended（おすすめ）:** Skim Tutorial 1 in Step 6. Try some
  of the code if you can. You do not need to finish every exercise.

## Step 1: Install R（Rのインストール）

1. Go to <https://cran.r-project.org/>
2. Click **Download R for Windows** → **base** → **Download R (latest version)**
   - Mac users: **Download R for macOS**, pick the file matching your Mac
     (Apple silicon = M1/M2/M3/M4, or older Intel)
3. Open the downloaded file and install with all default settings
   （すべてデフォルト設定のままでOK）

## Step 2: Install RStudio（RStudioのインストール）

1. Go to <https://posit.co/download/rstudio-desktop/>
2. Download **RStudio Desktop** (free) and install it

## Step 3: Install the packages we use（パッケージのインストール）

1. Open **RStudio**
2. Find the **Console** (the panel with the `>` symbol)
3. Copy this line into the Console, press **Enter**, and wait
   (it can take several minutes — lots of downloading is normal):

```r
install.packages(c("ggplot2", "rmarkdown", "knitr"))
```

4. If it asks a question, answering **Yes**/**OK** is fine.

## Step 4: Test everything（動作確認）

Paste this into the Console and press Enter:

```r
library(ggplot2)
ggplot(data.frame(x = rnorm(500)), aes(x)) +
  geom_histogram(fill = "steelblue", bins = 30) +
  ggtitle("It works! See you at RIKEN!")
```

If a blue histogram appears in the **Plots** panel: **you are ready!** 🎉

You can also run our full test script: open `setup/test_setup.R` in RStudio
and click **Source** (top-right of the editor panel).

## Step 5: Get these materials（教材の入手）

- If you received a ZIP file: unzip it somewhere easy to find (e.g. Desktop)
- If you use GitHub: click the green **Code** button → **Download ZIP**

Then double-click **`ScienceHighSchool.Rproj`** — RStudio opens with
everything in the right place.

## Step 6: Meet R before the camp（おすすめの予習）

Please at least skim **Tutorial 1: Welcome to R** before the camp. This will
help us start the main activities sooner on Day 2. If you have more time, try
some of the code too.

You will see several versions of the tutorial:

| File | What it is for | How to open it |
|---|---|---|
| `tutorials/01_welcome_to_r.html` | Read the finished tutorial | Open it in your web browser |
| `tutorials/01_welcome_to_r_notebook.Rmd` | Run and change the R code | Open it in RStudio |
| `tutorials/01_welcome_to_r.qmd` | Source file used to build the HTML page | You can ignore this file |

The **HTML** version is the quickest way to skim the lesson. It shows the
text, code, and results, but it does not run code.

For hands-on practice, open `tutorials/01_welcome_to_r_notebook.Rmd` in
RStudio. Run each code block with the green **Run** button. You can also place
your cursor in the code and press **Cmd/Ctrl + Enter**.

If you only have a little time, read the HTML version. If you have more time,
try the notebook too.

## Trouble? （うまくいかないときは）

| Problem | Fix |
|---|---|
| "R is not found" when starting RStudio | Install R first (Step 1), then reopen RStudio |
| `install.packages` shows red text | Red text is often just progress messages! It only failed if it says `Error` |
| School laptop blocks installation | Tell us — we will prepare a backup (Posit Cloud, runs in the browser) |
| Anything else | Email us a screenshot — screenshots beat descriptions |

**See you at the camp!**
