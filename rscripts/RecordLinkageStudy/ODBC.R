# https://blogs.oracle.com/R/entry/r_to_oracle_database_connectivity
# http://www.statmethods.net/input/dbinterface.html
# http://cran.r-project.org/web/packages/RODBC/vignettes/RODBC.pdf
# http://cran.r-project.org/web/packages/RODBC/RODBC.pdf
# http://rprogramming.net/connect-to-database-in-r/

library(RODBC)
#http://rprogramming.net/connect-to-ms-access-in-r/
#odbcConnectAccess is only usable with 32-bit Windows
odbcConnectAccess(access.file = "exampledsn")

# PARA SISTEMAS 64 bits
channel <- odbcConnect(dsn = "exampledsn", uid = "", pwd = "")





