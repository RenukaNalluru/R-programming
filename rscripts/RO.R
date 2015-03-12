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

    
    
    
    
    
    
    