#This is a simple file on how to add dummy variables with 
install.packages("foreign")

library(dplyr)
library(foreign)

data<-cross_country_data

#Generate country list
country_list=c()
iso<-data$country_iso
for (i in 1:dim(data)[1]){
  jug<-iso[i] %in% country_list
  if(jug==0){
    country_list <- append(country_list,iso[i])
  }
}

#Creating dummies and assign them names
numrow <-dim(data)[1]
ln_exp <- data$log_expenditure_pc_pwt
number_countries <- 39
for(i in 1:number_countries) {                                   # Head of for-loop
  new <- ifelse(data$country_no== i, 1, 0)                       # Create new column identified as dummy
  data[ , ncol(data) + 1] <- new                                 # Append this column to the existing data
  colnames(data)[ncol(data)] <- country_list[i]                  # Rename column name according to the existing list
}
