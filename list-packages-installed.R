pack <- installed.packages(fields = "Package")

pack[pack[, "Package"] == "ORE", ] 

library(ORE)
ORE::OREShowDoc()

df <- data.frame(A=1:26, B=letters[1:26])
ore.create(x = df, table = "DF_TABLE")


ore.pull("SI3_FONETIC")
ore.push(c(1,2,3,4,5))
