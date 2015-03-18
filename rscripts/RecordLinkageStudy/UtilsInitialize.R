library(ipred)
library(RecordLinkage)
library(RSQLite)
library(ff)
library(RJDBC)
library(SOAR)



construct.JDBCConnection <- function(driveClass = NULL, classPath = NULL, idq = " ") {
    drive <- JDBC(driverClass = driveClass, classPath = classPath, identifier.quote = idq)
    drive
}

def.connection.oracle <- function(drive = NULL, str, user, pwd) {
    if(is.null(drive) || missing(drive)) {
        ans <- "Erro ao abrir conexao"
        ans
    }
    conn <- RJDBC::dbConnect(drv = drive, str, user, pwd)
    conn
} 

def.workdirectory <- function(str) {
    setwd(dir = str)
}

exec.query <- function(conn, sql) {
    df <- RJDBC::dbGetQuery(conn, sql)
    df
}