#IODS week 5 data wrangling exercise
#Annasofia
#original data: http://hdr.undp.org/en/content/human-development-index-hdi

#loading the data
human2 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=",", header=T)
dim(human2)
#the dataset 'human2' has 195 observations and 19 variables
str(human2)
#Here is a list of the variables: HDI.Rank, Country, HDI, Life.Exp, Edu.Exp, Edu.Mean, GNI, GNI.Minus.Rank, GII.Rank, GII, Mat.Mor, Ado.Birth, Parli.F, Edu2.F, Edu2.M, Labo.F, Labo.M, Edu2.FM, Labo.FM
#Information about the variables: https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt

#transform the GNI variable to numeric
install.packages("stringr")
library(stringr)
human2$GNI <- str_replace(human2$GNI, pattern=",", replace ="") %>% as.numeric()

#exlude unneeded variables
keep <-c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human2 <- select(human2, one_of(keep))

#complete the data  wrangling
complete.cases(human2)
data.frame(human[-1], comp=complete.cases(human2))
human2 <- filter(human2, complete.cases(human2))
tail(human2, 10)
last <- nrow(human2)- 7
human2 <-human2[1:last, ]
rownames(human2) <- human2$Country

library(dplyr)
library(GGally)

human2 <-dplyr::select(human2, -Country)
dim(human2)
#[1] 155   8. Seems right!

write.table(human2,"~/Git/IODS-project/Data_wrangling/human2.csv", sep=",", row.names = TRUE)
