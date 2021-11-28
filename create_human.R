#Week 4 of IODS
#This is the data wrangling exercise

#Reading the data into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Exploring the dimensions and structures of "hd"
dim(hd)
str(hd)
#hd has 195 observations and 8 variables

#Exploring the dimensions and structures of "gii"
dim(gii)
str(gii)
#gii has 195 observations and 10 variables

#Creating summaries of the variables
summary(hd)
summary(gii)

#Renaming the columns

library(dplyr)
colnames(hd)
#[1] "HDI.Rank" [2] "Country" [3] "Human.Development.Index..HDI." [4] "Life.Expectancy.at.Birth" [5] "Expected.Years.of.Education" [6] "Mean.Years.of.Education" [7] "Gross.National.Income..GNI..per.Capita"[8] "GNI.per.Capita.Rank.Minus.HDI.Rank"    

#In my opinion, the first (HDI.Rank) and the second (Country) columns have decent names already. I will rename the 3-8 columns.
colnames(hd)[3]<- "HDI" 
colnames(hd)[4]<- "LE.Birth" 
colnames(hd)[5]<- "Exp.YoEdu" 
colnames(hd)[6]<- "Mean.YoEdu"
colnames(hd)[7]<- "GNI.perCap" 
colnames(hd)[8]<- "GNI.minus.HDI"
colnames(hd)

colnames(gii)
#[1] "GII.Rank"[2] "Country"[3] "Gender.Inequality.Index..GII."[4] "Maternal.Mortality.Ratio"[5] "Adolescent.Birth.Rate"[6] "Percent.Representation.in.Parliament"[7] "Population.with.Secondary.Education..Female."[8] "Population.with.Secondary.Education..Male." [9] "Labour.Force.Participation.Rate..Female." [10] "Labour.Force.Participation.Rate..Male."     
#Again, the first (GII.Rank) and the second (Country) column names are okay
colnames(gii)[3]<-"GII" 
colnames(gii)[4]<-"MaMoRatio"
colnames(gii)[5]<-"Ado.BR" 
colnames(gii)[6]<-"Per.Rep.Parl" 
colnames(gii)[7]<-"Pop.SEdu.F" 
colnames(gii)[8]<-"Pop.SEdu.M" 
colnames(gii)[9]<-"Lab.Fo.Par.F"
colnames(gii)[10]<-"Lab.Fo.Par.M"
colnames(gii)

#Mutate the “Gender inequality” data and create two new variables
gii <- mutate(gii, RatioSEdu = (Pop.SEdu.F/ Pop.SEdu.M))
gii <- mutate(gii, RatioLab = (Lab.Fo.Par.F/ Lab.Fo.Par.M))

#Join together the two datasets
join_by <- c("Country")
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))
dim(human)
write.csv(human, "~/Git/IODS-project/Data_wrangling/human.csv", row.names=FALSE)
