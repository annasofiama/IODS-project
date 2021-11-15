# Annasofia Martikkala, 11.11.21, RStudio Exercise 2
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(learning2014)
#This data has 183 rows (the observations) and 60 columns (the variables)
str(learning2014)
#Exploring the structure of the data showed me the columns, for example 'Age', 'Attitude', 'Points* and 'gender'
library(dplyr)
install.packages(dplyr)
install.packages("dplyr")
library(dplyr)
#questions related to gender
gender_questions <- c(Gender)
#questions related to deep learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
#questions related to attitude
attitude_questions <-c("Da","Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj")
#questions related to strategic learning
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
#questions related to surface
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
#questions related to points
points_questions <-c("Points")
#questions related to gender
gender_questions <-c("Gender")
#questions related to age
age_questions <-c("Age")

#creating column deep
deep_column <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_column)
#creating column attitude
attitude_column <- select(learning2014, one_of(attitude_questions))
learning2014$attitude <- rowMeans(attitude_column)
#creating column strategic
strategic_column <- select(learning2014, one_of(strategic_questions))
learning2014$strategic <- rowMeans(strategic_column)
#creating column surface
surface_column <-select(learning2014, one_of(surface_questions))
learning2014$surface <- rowMeans(surface_column)
#creating column gender
gender_column <- select(learning2014, one_of(gender_questions))
#creating column points
points_column <- select(learning2014, one_of(points_questions))
learning2014$points <- rowMeans(points_column)
#creating column age
age_column <- select(learning2014, one_of(age_questions))
learning2014$age <-rowMeans(age_column)
#checking the dimensions of the data
dim(learning2014)
# choosing the colums I want to keep
keep_column <- c("deep","age","attitude", "strategic", "surface","Gender", "Points")
# creating a new dataset
lrn14 <- select(learning2014, one_of(keep_column))
str(lrn14)
keep_column <-c("deep", "age", "attitude", "strategic", "surface", "gender", "Points")
lrn14 <- select(learning2014, one_of(keep_column))
str(lrn14)
#excluding zero examp point
lrn14new <- subset(lrn14, Points==0)
str(lrn14)
dim(lrn14new)
str(lrn14new)
learning2014new <- subset(lrn14, Points>0)
dim(learning2014new)
write.csv(learning2014new)
stra(learning2014new)
str(learning2014new)
write.table(learning2014new)
write.csv(learning2014new, "~/Git/IODS-project/data/learning2014new2.csv", row.names=TRUE)
read(learning2014new2)
read.cvs(learning2014new2)
read.csv(learning2014new2)
read.csv("~/Git/IODS-project/data/learning2014new2.csv")
str(learning2014new2)
write.csv(learning2014new, "~/Git/IODS-project/data/learning2014new2.csv", row.names=FALSE)
read.csv("~/Git/IODS-project/data/learning2014new2.csv")
str(learning2014new2)
