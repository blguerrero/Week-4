#Programming Assignment 3
#1- Plot the 30-Day Mortality Rates for Heart Attack
setwd("~/Desktop/Coursera/R Programming/Week 4/rprog_data_ProgAssignment3-data")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
#how many columns are there
ncol(outcome)
names(outcome)
#histogram of 30-day death rates from heart attack (column 11)
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

#2- Finding the best hospital in a state
best <- function(state, outcome) {
  #read.csv
  outcome1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #check validity of state
  #saying if you input random letters that do not = a state an error message of 'invalid state' will appear
  if (!any(state == outcome1$State)) {
    stop("invalid state")
  }
  #check validity of outcome
  #when using the function, if the second argument input is not heart attack, heart failure, 
  #or pneumonia, the output will print 'invalid outcome'
  else if((outcome %in% c("heart attack", "heart failure", "pneumonia")) == FALSE) {
    stop(print("invalid outcome"))
  }
  #tells R which column to pull from depending on what was input for arg 2
  outcome2 <- subset(outcome1, State == state)
  if (outcome == "heart attack") {
    colnum <- 11}
  else if (outcome == "heart failure") {
    colnum <- 17}
  else if (outcome == "pneumonia") {
    colnum <- 23
  }
  #want func to return the lowest 30-day death rate, because the best hospital is the one with the least rate of deaths
  #so the function should pull info from the row with the minimum value in outcome 2
  #outcome 2 stored the 30 Day Death Mortality Rates by heart attack, heart failure, and pneumonia
  #so, depending on the outcome input into the function, it should use info from the row with the lowest number
  min_row <-(as.numeric(outcome2[ ,colnum])) == min(as.numeric(outcome2[ ,colnum]), na.rm = TRUE)
  #second outcome of the function should be the min_row (lowest death rate), second column value
  #col 2 is hospital names
  hospitals <- outcome2[min_row,2]
  hospitals <- sort(hospitals)
  #should return the first hospital
  return(hospitals[1])
}
best("SC", "heart attack")
best("TX", "heart attack")
