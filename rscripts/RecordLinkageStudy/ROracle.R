#https://blogs.oracle.com/R/entry/r_to_oracle_database_connectivity
install.packages("ROracle")
library("ROracle")

drive <- dbDriver(paste(getwd(), "/ojdbc6.jar", sep = ""))
