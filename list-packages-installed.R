pack <- installed.packages(fields = "Package")
pack[pack[, "Package"] == "OREembed", ]

install.packages("ROracle")

setwd(dir = "C:/Users/christoffer/Desktop/R-programming")

library(ipred)
library(OREbase)
library(OREembed)
library(ORE)
library(ROracle)

ORE::OREShowDoc()

df <- data.frame(A=1:26, B=letters[1:26])
ore.create(x = df, table = "DF_TABLE")


ore.pull("SI3_FONETIC")
ore.push(c(1,2,3,4,5))

??ore

ore.connect(user="hr", sid="xe", host="hr@//localhost:1521/xe", password="admin", port="1521", all=T)
ore