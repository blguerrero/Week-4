#swirl Week 4 - Looking at Data
library(swirl)
swirl()
#We'll be using a dataset constructed from the United States Department of Agriculture's PLANTS Database
#to see what variables are in our workspace/environment
ls()
#to look at the overall structure of the data
class(plants)
#to see number of rows and columns
#first number is rows, second is columns
dim(plants)
#or
nrow(plants)
ncol(plants)
#see how much memory space dataset is taking up
object.size(plants)
#to see names of variables in the dataset
names(plants)
#see first 6 rows
head(plants)
#see first 10 rows
head(plants, 10)
#see last 15 rows
tail(plants, 15)
#shows # of NAs
summary(plants)
#to see breakdown of specific variable
table(plants$Active_Growth_Period)
#to see everything done above in one place
str(plants)

#swirl - Simulation
?sample
#simulate rolling four six-sided dice
#repeat to see how results differ
#replace = TRUE means w/replacement --> numbers can be repeated
sample(1:6, 4, replace = TRUE)
#Now sample 10 numbers between 1 and 20, WITHOUT replacement
sample(1:20, 10)
LETTERS
#take a sample of size 26 from LETTERS w/o replacement
#if size is not specified it will be the length of the vector you are sampling
sample(LETTERS)
#simulate 100 flips of an unfair two-sided coin. This particular coin has a 0.3 probability of landing
#'tails' and a 0.7 probability of landing 'heads'
flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))
flips
#to count number of 1s
sum(flips)
#coin flip is a binary outcome (0 or 1), we can use rbinom() to simulate a binomial random variable
?rbinom
#in rbinom you can only specify the probability of 'success' (heads) and NOT the probability of
#'failure' (tails)
rbinom(1, size = 100, prob = 0.7)
#if we want to see all of the 0s and 1s, we can request 100 observations, each of size 1, 
#with success probability of 0.7
flips2 <- rbinom(100, size = 1, prob = 0.7)
flips2
sum(flips2)
?rnorm
#rnorm(10) will generate 10 random numbers from a standard normal distribution
#a standard normal distribution has mean 0 and standard deviation 1
rnorm(10)
#do the same, except with a mean of 100 and a standard deviation of 25
rnorm(10, mean = 100, sd = 25)
?rpois
#Generate 5 random values from a Poisson distribution with mean 10
#in rpois lambda is mean
rpois(5, lambda = 10)
#perform this operation 100 times
#creates a matrix with 100 columns and 5 rows
my_pois <- replicate(100, rpois(5, 10))
my_pois
#create a vector of column means
cm <- colMeans(my_pois)
#take a look at the distribution of our column means by plotting a histogram
hist(cm)

#Base Graphics
#See http://varianceexplained.org/r/teach_ggplot2_to_beginners/ for an outline 
data(cars)
?cars
head(cars)
#R notes that the data frame you have given it has just two columns, so it assumes 
#that you want to plot one column versus the other. R uses the names of the columns. Third, it
#creates axis tick marks at nice round numbers and labels them accordingly
#plot is short for scatterplot
plot(cars)
?plot
plot(x = cars$speed, y = cars$dist)
#can also use plot(dist ~ speed, cars)
#Use plot() command to show dist on the x-axis and speed on the y-axis
plot(x = cars$dist, y = cars$speed)
#Recreate the plot with the label of the x-axis set to "Speed"
plot(x = cars$speed, y = cars$dist, xlab = "Speed")
#Recreate the plot with the label of the y-axis set to "Stopping Distance".
plot(x = cars$speed, y = cars$dist, ylab = "Stopping Distance")
#Recreate the plot with "Speed" and "Stopping Distance" as axis labels.
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")
#The reason that plots(cars) worked at the beginning of the lesson was that R was smart enough to know
#that the first element (i.e., the first column) in cars should be assigned to the x argument and the
#second element to the y argument
plot(cars, main = "My Plot")
plot(cars, sub = "My Plot Subtitle")
?par
#Plot cars so that the plotted points are colored red. (Use col = 2 to achieve this effect.)
plot(cars, col = 2)
#Plot cars while limiting the x-axis to 10 through 15.  (Use xlim = c(10, 15) to achieve this effect.)
plot(cars, xlim = c(10,15))
?points
plot(cars, pch = 2)
#boxplots
data(mtcars)
?boxplot
#Use boxplot() with formula = mpg ~ cyl and data = mtcars to create a box plot.
boxplot(mpg~cyl, mtcars)
#Use hist() with the vector mtcars$mpg to create a histogram.
hist(mtcars$mpg)
#If you want to explore other elements of base graphics, then this web page
#(http://www.ling.upenn.edu/~joseff/rstudy/week4.html) provides a useful overview