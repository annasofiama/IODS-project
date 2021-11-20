#Annasofia Martikkala
#20.11.2021
#This data is downloaded from UCI Machine Learning repository. This data approach student achievement in secondary education of two Portuguese schools.

# read the datasets into memory
por <- read.table("~/Git/IODS-project/Data_wrangling/student-por.csv", sep = ";", header=TRUE)
math <- read.table("~/Git/IODS-project/Data_wrangling/student-mat.csv", sep = ";", header=TRUE)

# explore the structure and dimensions of por
str(por)
dim(por)
# por has 649 observations and 33 variables

# explore the structure and dimensions of math
str(math)
dim(math)
# math has 395 observations and 33 variables

# Define own id for both datasets
library(dplyr)
por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# Combine datasets to one long data
pormath <- por_id %>% 
  bind_rows(math_id) %>%

# Aggregate data (more joining variables than in the example)  
group_by(.dots=join_cols) %>%

# Calculating required variables from two obs
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     #  Rounded mean for numerical
    paid=first(paid),                   #    and first for chars
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%

# Remove lines that do not have exactly one obs from both datasets
  filter(n==2, id.m-id.p>650) %>%

# Join original free fields, because rounded means or first values may not be relevant
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%

# Calculate other required variables  
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )
# Save created data to folder 'Data_wrangling' as an Excel worksheet
install.packages("openxlsx")
library(openxlsx)
write.xlsx(pormath,file="~/IODS-project/Data_wrangling/pormath.xlsx")

# Explore the sructure and dimensions of the joined data
str(pormath)
dim(pormath)
# pormath has 370 observations and 51 variables