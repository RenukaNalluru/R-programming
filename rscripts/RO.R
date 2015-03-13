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

?OREbase::ore.exe    
object <- print(OREbase::ore.exec(qry = "SELECT * FROM SI3_FONETIC"))
    
ore.exists(name = "SI3_FONETIC")
    
OREbase::ore.create(x = data.frame(c(1:10), row.names = c(1:10)), table = "ANY_TABLE")
OREbase::ore.drop(table = "ANY_TABLE")

?Oracle   # package ROracle
?dbDriver # package DBI
dbDriver("Oracle")



# teste com rJava

.jinit()
vect <- .jnew("java/util/Vector")
