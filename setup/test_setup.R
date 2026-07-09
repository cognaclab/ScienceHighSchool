# ============================================================
# test_setup.R - run me to check your computer is camp-ready!
# In RStudio: open this file and click "Source" (top right).
# ============================================================

cat("Checking your setup...\n\n")

# 1. R version
r_ok <- getRversion() >= "4.0.0"
cat(if (r_ok) "[OK]  " else "[!!]  ", "R version: ", as.character(getRversion()),
    if (!r_ok) "  -> please install a newer R from cran.r-project.org" else "", "\n", sep = "")

# 2. packages
packages <- c("ggplot2", "rmarkdown", "knitr")
package_ok <- vapply(packages, requireNamespace, logical(1), quietly = TRUE)

for (pkg in packages) {
  ok <- package_ok[[pkg]]
  cat(if (ok) "[OK]  " else "[!!]  ", pkg, " package",
      if (!ok) '  -> run: install.packages(c("ggplot2", "rmarkdown", "knitr"))' else "",
      "\n", sep = "")
}

# 3. A tiny simulation + plot
if (package_ok[["ggplot2"]]) {
  library(ggplot2)
  rolls <- sample(1:6, 1000, replace = TRUE)
  print(
    ggplot(data.frame(rolls), aes(x = rolls)) +
      geom_bar(fill = "steelblue") +
      scale_x_continuous(breaks = 1:6) +
      labs(title = "1000 dice rolls - your computer is camp-ready!",
           x = "result", y = "count")
  )
  cat("[OK]  simulation + plot (check the Plots panel!)\n")
}

if (r_ok && all(package_ok)) {
  cat("\nPERFECT! You are ready for the camp. See you at RIKEN!\n")
} else {
  cat("\nSomething needs fixing - see setup/setup_guide.md or email us.\n")
}
