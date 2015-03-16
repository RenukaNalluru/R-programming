# Introducing Oracle R Enterprise
# https://docs.oracle.com/cd/E57012_01/doc.141/e56973/intro.htm#OREUG187


library(OREbase)
library(OREcommon)
library(OREembed)
library(ORE)
library(DBI)
library(ROracle)

#https://blogs.oracle.com/R/entry/r_to_oracle_database_connectivity

#http://stackoverflow.com/questions/5339796/loading-an-r-package-from-a-custom-directory
install.packages("C:/oreclient_install_dir/client/*.zip", repos=NULL, type="source")
install.packages("C:/oreclient_install_dir/supporting/*.zip", repos=NULL, type="source")
install.packages("DBI")
install.packages("C:/Users/christoffer/Desktop/RScriptsForOracle/ROracle_1.1-12.tar", repos=NULL, type="source")
OREbase::factorial(x = 100)

?ore.connect

ore.connect(user = "hr", sid = "xe", host = "localhost", password = "admin", port = 1521)
OREbase::ore.is.connected()
?OREbase::ore.connect
?OREbase::ore.exec

OREbase::ore.exec(qry = "SELECT * FROM SI3_FONETIC")
# object <- print(OREbase::ore.exec(qry = "SELECT * FROM SI3_FONETIC"))
    
OREbase::ore.create(x = data.frame(x = c(1:10), row.names = c(1:10)), table = "ANY_TABLE")
ore.get("ANY_TABLE")
ore.exists("ANY_TABLE")
OREbase::ore.drop(table = "ANY_TABLE")


?interactive
?OREbase::ore.get

OREbase::ore.disconnect()



?Oracle   # package ROracle
?dbDriver # package DBI
drive <- dbDriver("Oracle")
conn <- dbConnect(drv = drive, "hr", "admin")
table <- dbReadTable(conn, name = "SI3_FONETIC")

setwd(dir = "C:/Users/christoffer/Desktop/R-programming/")
f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsRecordLinkage.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())

unix.time(expr = sapply(1:ncol(table), function(i) nrow(table[is.na(table[, i]), ])))
# user  system elapsed 
# 1.25    0.05    1.30

unix.time(table.notna <- listNotNa(X = table, fields = 1))
# user  system elapsed 
# 1.66    0.03    1.70 

unix.time(table.notna <- clear.all.matrix(data = table.notna, fields = 2:ncol(table.notna)))
# user  system elapsed 
# 5.14    0.18    5.36

# demo(package = "ORE")
# teste com rJava

dbDisconnect(conn = conn);

.jinit()
vect <- .jnew("java/util/Vector")
