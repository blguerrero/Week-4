#4- Ranking hospitals in all states
rankall <- function(outcome, num = "best") {
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