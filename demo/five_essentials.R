# ============================================================
#  SARA Summer School — 3rd Edition
#  "R for Researchers"
#  Five Essentials of R Coding
# ============================================================
#  How to use this file:
#  - Run one line at a time: place cursor on a line → Ctrl+Enter (Win) / Cmd+Enter (Mac)
#  - Run a whole section:    select lines → Ctrl+Enter
#  - Run this full file:     Ctrl+Shift+Enter
#  - Output appears in the Console below
# ============================================================

# ────────────────────────────────────────────────────────────
# ESSENTIAL 1: VARIABLES & DATA TYPES
# ────────────────────────────────────────────────────────────
# A variable stores a value so you can reuse it.
# Use  <-  to assign (R's way of saying "equals").

name <- "SARA Institute" # character  (text — always in quotes)
year <- 2023 # numeric    (whole number)
fee <- 4500.00 # numeric    (decimal)
is_free <- FALSE # logical    (TRUE or FALSE)


# Print a variable — just type its name and run
name
year
fee
is_free

# Check what type a variable is
class(name) # "character"
class(year) # "numeric"
class(is_free) # "logical"

# Useful: see a quick summary of any object
str(name)
str(year)

# ── YOUR TURN ──────────────────────────────────────────────
# 1. Create a variable called my_name with your name.
# 2. Create a variable called my_city with your city.
# 3. Print both. What class are they?
# ──────────────────────────────────────────────────────────

# ────────────────────────────────────────────────────────────
# ESSENTIAL 2: VECTORS
# ────────────────────────────────────────────────────────────
# A vector is a sequence of values of the SAME type.
# c() means "combine" — it is how you build a vector.

students <- c("Priya", "Rahul", "Anita", "Suresh", "Meena")
scores <- c(88, 75, 92, 60, 85)
passed <- c(TRUE, TRUE, TRUE, FALSE, TRUE)

# Access individual elements — R starts counting from 1
students[1] # first student → "Priya"
scores[3] # third score   → 92
students[2:4] # elements 2 to 4
scores[c(1, 5)] # elements 1 and 5

# Arithmetic on the whole vector at once (R's superpower!)
scores + 5 # add 5 bonus marks to everyone
scores * 1.1 # increase all scores by 10%
scores >= 70 # TRUE/FALSE — who scored 70 or above?

# Built-in summary functions
length(scores) # how many elements?
sum(scores) # total
mean(scores) # average
median(scores) # middle value
max(scores) # highest
min(scores) # lowest
range(scores) # min and max together
sd(scores) # standard deviation

# ── YOUR TURN ──────────────────────────────────────────────
# 1. Create a vector of 5 temperatures (any values you like).
# 2. Find the mean, max, and min.
# 3. Which temperatures are above 30? (use >= 30)
# ──────────────────────────────────────────────────────────

# ────────────────────────────────────────────────────────────
# ESSENTIAL 3: DATA FRAMES
# ────────────────────────────────────────────────────────────
# A data frame is a table — rows are observations,
# columns are variables. It is the most used structure
# in data analysis.

participants <- data.frame(
  name = c("Priya", "Rahul", "Anita", "Suresh", "Meena"),
  city = c("Delhi", "Jaipur", "Mumbai", "Lucknow", "Pune"),
  score = c(88, 75, 92, 60, 85),
  passed = c(TRUE, TRUE, TRUE, FALSE, TRUE)
)

# Look at the data frame
participants # print the whole table
head(participants) # first 6 rows (useful for big data)
tail(participants) # last 6 rows
nrow(participants) # number of rows
ncol(participants) # number of columns
dim(participants) # rows and columns together
names(participants) # column names
str(participants) # structure — types of each column
summary(participants) # quick stats for each column

# Access columns using $ — gives you the whole column as a vector
participants$name
participants$score

# Access a specific row, column [row, column]
participants[1, ] # first row, all columns
participants[, 3] # all rows, third column (score)
participants[2, 3] # row 2, column 3 → Rahul's score

# Filter rows — who passed?
participants[participants$passed == TRUE, ]

# Who scored above 80?
participants[participants$score > 80, ]

# Add a new column
participants$grade <- ifelse(participants$score >= 80, "Distinction", "Pass")
participants

# ── YOUR TURN ──────────────────────────────────────────────
# 1. Create a data frame with 4 of your friends:
#    name, age, and favourite_subject.
# 2. Print only the name and favourite_subject columns.
# 3. Filter: who is older than 25?
# ──────────────────────────────────────────────────────────

# ────────────────────────────────────────────────────────────
# ESSENTIAL 4: FUNCTIONS
# ────────────────────────────────────────────────────────────
# A function is a reusable block of code that does one job.
# You have already used built-in functions: mean(), sum(), c()
# Now learn to write your own.

# Basic structure:
# my_function <- function(argument1, argument2) {
#   # code that does something
#   return(result)
# }

# Example 1 — greet a participant
greet <- function(name) {
  message <- paste("Welcome to SARA Summer School,", name, "!")
  return(message)
}

greet("Priya")
greet("Rahul")

# Example 2 — convert marks to percentage
to_percent <- function(marks, total = 100) {
  # total has a default value
  percent <- (marks / total) * 100
  return(round(percent, 2)) # round to 2 decimal places
}

to_percent(75) # out of 100 (default)
to_percent(45, total = 60) # out of 60

# Example 3 — classify a score
classify_score <- function(score) {
  if (score >= 90) {
    return("Excellent")
  } else if (score >= 75) {
    return("Good")
  } else if (score >= 60) {
    return("Pass")
  } else {
    return("Needs Improvement")
  }
}

classify_score(92)
classify_score(78)
classify_score(55)

# Apply your function to a whole vector using sapply()
sapply(scores, classify_score)

# ── YOUR TURN ──────────────────────────────────────────────
# 1. Write a function called celsius_to_fahrenheit
#    that converts temperature:  F = (C × 9/5) + 32
# 2. Test it with 0, 100, and 37 (body temperature).
# ──────────────────────────────────────────────────────────

# ────────────────────────────────────────────────────────────
# ESSENTIAL 5: PACKAGES & BASIC PLOTTING
# ────────────────────────────────────────────────────────────
# R's power comes from packages — collections of ready-made
# functions. You install a package once, then load it
# every session with library().

# --- Base R plotting (no package needed) ---

# Bar chart — scores of participants
barplot(
  participants$score,
  names.arg = participants$name,
  col = c("#0A4F6E", "#1A7FA0", "#3AAFA9", "#E8735A", "#F9C74F"),
  main = "SARA Summer School — Participant Scores",
  xlab = "Participant",
  ylab = "Score",
  ylim = c(0, 100)
)

# Add a pass line at 60
abline(h = 60, col = "#E8735A", lty = 2, lwd = 2)

# Histogram — distribution of scores
hist(
  participants$score,
  col = "#5BB8D4",
  border = "#0A4F6E",
  main = "Score Distribution",
  xlab = "Score",
  ylab = "Frequency",
  breaks = 5
)

# Scatter plot — if you had two numeric variables
plot(
  x = c(1, 2, 3, 4, 5),
  y = participants$score,
  col = "#E8735A",
  pch = 19, # filled circle point
  cex = 1.5, # point size
  main = "Scores by Participant Order",
  xlab = "Order",
  ylab = "Score"
)
lines(c(1, 2, 3, 4, 5), participants$score, col = "#1A7FA0", lwd = 2)

# --- Installing and using a package ---
# Uncomment the line below to install (only needed once):
# install.packages("ggplot2")

# Load the package (every session)
# library(ggplot2)

# Once loaded, ggplot2 works like this:
# ggplot(participants, aes(x = name, y = score, fill = name)) +
#   geom_col() +
#   theme_minimal() +
#   labs(title = "SARA Scores", x = "Participant", y = "Score")

# ── YOUR TURN ──────────────────────────────────────────────
# 1. Create a vector of monthly rainfall:
#    rainfall <- c(5, 8, 45, 120, 180, 200, 210, 190, 130, 40, 10, 3)
# 2. Make a barplot with month names on the x-axis.
# 3. Which month has the highest rainfall? Use which.max()
# ──────────────────────────────────────────────────────────

# ============================================================
#  SUMMARY — Five Essentials of R
# ============================================================
#
#  1. VARIABLES & DATA TYPES
#     Store values with <-
#     Types: character, numeric, logical
#     Check with: class(), str()
#
#  2. VECTORS
#     Sequence of same-type values: c()
#     Arithmetic works on the whole vector
#     Summarise with: mean(), sum(), max(), min(), sd()
#
#  3. DATA FRAMES
#     Tables: rows = observations, columns = variables
#     Access with: $, [ , ], filter with conditions
#     Inspect with: head(), str(), summary()
#
#  4. FUNCTIONS
#     Reusable blocks: function(arg) { ... return() }
#     Use default arguments for flexibility
#     Apply to vectors with: sapply()
#
#  5. PACKAGES & PLOTTING
#     Install once: install.packages("name")
#     Load every session: library("name")
#     Base R plots: barplot(), hist(), plot()
#     Advanced: ggplot2 (the gold standard for research)
#
# ============================================================
#  Well done! You now know the five pillars of R coding.
#  Next step: load your own data with read.csv() and explore!
# ============================================================

greet <- function(name) {
  print(paste("Namaste!", name))
}

greet('Ajay')

greet("Kiran")

greet("Kiara")

add_numbers <- function(x, y) {
  result <- x * y
  return(result)
}

add_numbers(2, 3)
