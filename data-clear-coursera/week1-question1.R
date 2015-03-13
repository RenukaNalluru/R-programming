# questao 1 week 1
setwd(dir = "C:/Users/christoffer/Desktop/R-programming")
file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
?download.file
download.file(url = file, destfile = paste(getwd(),"/data-clear-coursera/quiz.csv", sep = ""), method = "auto")

table <- read.table(file = "data-clear-coursera/quiz.csv", header = T, sep = ",")
head(table)
ncol(table) # 188
nrow(table) # 6496

# coluna VAL  indica o valor da propriedade
table[, c("VAL")]
table[table[, c("VAL")] == "24", ]

#http://stackoverflow.com/questions/2190756/in-r-how-to-count-true-values-in-a-logical-vector
?which
length(which(table[, c("VAL") ] == 24))

sum(table[, c("VAL") ] == 24, na.rm = T)

table[, c("FES")]


#question 3
library(xlsx)
file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = file, destfile = paste(getwd(), "/data-clear-coursera/getdata_data_DATA.gov_NGAP.xlsx", sep = ""), method="auto")

head(read.xlsx(file = paste(getwd(),"/data-clear-coursera/getdata_data_DATA.gov_NGAP.xlsx", sep = ""), sheetIndex = 1))
     
xl <- read.xlsx(file = paste(getwd(),"/data-clear-coursera/getdata_data_DATA.gov_NGAP.xlsx", sep = ""), sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15, header = T)
sum(xl[, "Zip"] * xl[, "Ext"], na.rm = T)

#question 4

library(XML)
file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(url = file, destfile = paste(getwd(), "/data-clear-coursera/getdata_data_restaurants.xml", sep = ""), method="auto")
docTree <- XML::xmlTreeParse(paste(getwd(), "/data-clear-coursera/getdata_data_restaurants.xml", sep = ""))
# object.size(docTree) / 1024 ^ 2

root <- XML::xmlRoot(docTree)
XML::xmlName(root)
XML::names.XMLNode(root)
names(root)
root[["row"]]
root[["row"]][["row"]][["zipcode"]]

data <- XML::xmlApply(X = root[["row"]], FUN = function(child) child[["zipcode"]] )


XML::xmlApply(X = root[["row"]], FUN = function(child) {
    class(child[["zipcode"]][1])
#     child[["zipcode"]][1]$text
#     child[["zipcode"]]$text
# child[["zipcode"]][[1]]$text
# child[["zipcode"]]
xmlValue(x = child[["zipcode"]])[1]
})

sum( XML::xmlApply(X = root[["row"]], FUN = function(child) xmlValue(x = child[["zipcode"]])[1]) == "21231")

# fim questao 4


# questao 5

file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = file, destfile = paste(getwd(), "/data-clear-coursera/getdata_data_ss06pid.csv", sep = ""), method = "auto")
table <- read.table(file = "data-clear-coursera/getdata_data_ss06pid.csv", header = T, sep = ",")

library(data.table)
DT <- fread("data-clear-coursera/getdata_data_ss06pid.csv", header = T, sep = ",")


system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
