#Annasofia
#Data wrangling exercise for week 6

#checking the working directory --> it's the right one
getwd()

library(dplyr)
library(tidyr)

#loading the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#let's take a look at the datasets: BPRS first

str(BPRS)
#40 obs. of  11 variables

colnames(BPRS)
#[1] "treatment" "subject"   "week0"     "week1"    
#[5] "week2"     "week3"     "week4"     "week5"    
#[9] "week6"     "week7"     "week8"   

summary(BPRS)

#and now RATS

str(RATS)
#16 obs. of  13 variables

colnames(RATS)
#[1] "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29" 
#[8] "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64"

summary(RATS)

#Convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Convert the data sets to long form.
#Add a week variable to BPRS and a Time variable to RATS.

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- gather(RATS, key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

#let's take a look at the data again

colnames(BPRSL)
#[1] "treatment" "subject"   "weeks"     "bprs"     
#[5] "week" 

str(BPRSL)
#360 obs. of  5 variables

summary(BPRSL)

colnames(RATSL)
#[1] "ID"     "Group"  "WD"     "Weight" "Time"

str(RATSL)
#176 obs. of  5 variables

summary(RATSL)

#let's save the data
write.csv(BPRSL, file = "C:/Users/Annasofia/Documents/Git/IODS-project/BPRSL.csv", row.names = F)
write.csv(RATSL, file = "C:/Users/Annasofia/Documents/Git/IODS-project/RATSL.csv", row.names = F)
