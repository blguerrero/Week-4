#Programming Assignment 3
#got help from https://rstudio-pubs-static.s3.amazonaws.com/241362_23b17a07c5364e3c96a8ed01097e1edb.html
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
  #rate -->sort so we get the #1 lowest hospital
  hospitals <- sort(hospitals)
  #should return the first hospital
  return(hospitals[1])
}
best("SC", "heart attack")
best("TX", "heart attack")

#3- Ranking hospitals by outcome in a state
rankhospital <- function(state, outcome, num = "best") {
  #same as best function
  outcome1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if (!any(state == outcome1$State)) {
    stop("invalid state")
  }
  else if((outcome %in% c("heart attack", "heart failure", "pneumonia")) == FALSE) {
    stop(print("invalid outcome"))
  }
  outcome2 <- subset(outcome1, State == state)
  if (outcome == "heart attack") {
    colnum <- 11}
  else if (outcome == "heart failure") {
    colnum <- 17}
  else if (outcome == "pneumonia") {
    colnum <- 23
  }
  #create numeric vector of each outcome
  outcome2[ ,colnum] <- as.numeric(outcome2[ ,colnum])
  #order organizes the list by ascending order
  #outcome3, is determined by how outcome2 is ranked
  outcome3 <- outcome2[order(outcome2[ ,colnum], outcome2[ , 2]), ]
  outcome3 <- outcome3[(!is.na(outcome3[ ,colnum])),]
  #the best hospital will be ranked 1
  if (num == "best") {
    num <- 1
  }
  #the worst hospital will be ranked last. Since the number of observations may be different for each
  #outcome (heart failure, heart attack, pneumonia). The worst(last) will be the number of rows in 
  #that outcome, hence, the use of nrow()
  else if (num == "worst") {
    num <- nrow(outcome3)
  }
  #want function to output the hospital name (column 2) based on the num input in the function
  return(outcome3[num,2])
}
rankhospital("TX", "heart failure", 4)

#4- Ranking hospitals in all states
rankall <- function(outcome, num = "best") {
  #not the same as best function
  #removed the state validation because state is not an argument in this function
  outcome2 <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
  if((outcome %in% c("heart attack", "heart failure", "pneumonia")) == FALSE) {
    stop(print("invalid outcome"))
  }
  if (outcome == "heart attack") {
    colnum <- 11
  }
  else if (outcome == "heart failure") {
    colnum <- 17
  }
  else {
    colnum <- 23
  }
  outcome2[ ,colnum] <- as.numeric(outcome2[ ,colnum])
  outcome2 = outcome2[!is.na(outcome2[,colnum]),]
  #split outcome2 by State of outcome2
  splitted = split(outcome2, outcome2$State)
  #our answer is based on the order(num) of what we split
  #want to apply the order to states of outcome2
  ans = lapply(splitted, function(x, num) {
    x = x[order(x[,colnum], x$Hospital.Name),]
  if(class(num) == "character") {
    if(num == "best") {
      return (x$Hospital.Name[1])
    }
    else if(num == "worst") {
      return (x$Hospital.Name[nrow(x)])
    }
  }
  else {
    return (x$Hospital.Name[num])
}
}  , num)
  return ( data.frame(hospital=unlist(ans), state=names(ans)) )
}
r <- rankall("heart attack", 4)
head(rankall("heart attack", 20), 10)

#Quiz
#1- What result is returned by the following code?
best("SC", "heart attack")
#"MUSC MEDICAL CENTER"

#2- What result is returned by the following code?
best("NY", "pneumonia")
#"MAIMONIDES MEDICAL CENTER"

#3- What result is returned by the following code?
best("AK", "pneumonia")
#"YUKON KUSKOKWIM DELTA REG HOSPITAL"

#4- 
rankhospital("NC", "heart attack", "worst")
#"WAYNE MEMORIAL HOSPITAL"

#5- 
rankhospital("WA", "heart attack", 7)
#"YAKIMA VALLEY MEMORIAL HOSPITAL"

#6- 
rankhospital("TX", "pneumonia", 10)
#"SETON SMITHVILLE REGIONAL HOSPITAL"

#7-
rankhospital("NY", "heart attack", 7)
#"BELLEVUE HOSPITAL CENTER"

#8- 
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)
#"CASTLE MEDICAL CENTER"

#9-
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
#"BERGEN REGIONAL MEDICAL CENTER"

#10-
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
#"RENOWN SOUTH MEADOWS MEDICAL CENTER"