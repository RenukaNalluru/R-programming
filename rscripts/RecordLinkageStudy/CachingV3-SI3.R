library(ipred)
library(RecordLinkage)
library(ff)
library(RJDBC)
library(SOAR)

setwd(dir = "C:/Users/christoffer/Desktop/R-programming/")
drive <- JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = paste(getwd(), "/ojdbc6.jar", sep = ""), identifier.quote = " ")
conn <- RJDBC::dbConnect(drv = drive, "jdbc:oracle:thin:@localhost:1521/xe", "hr", "admin")

unix.time(si3.fonetic <- RJDBC::dbGetQuery(conn, "SELECT * FROM SI3_FONETIC where rownum <2000"))
# usuario   sistema decorrido 
# 5.91      0.29      6.19

install.packages("R.cache")
library(R.cache)

#(C:\Users\CHRIST~1\AppData\Local\Temp\RtmpAvHBJ6

nrow(si3.fonetic) #1177129


f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsRecordLinkage.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())



sapply(1:ncol(si3.fonetic), function(i) nrow(si3.fonetic[is.na(si3.fonetic[, i]), ]))
# 0  22145      0      0 183779

unix.time(si3.fonetic.notna <- listNotNa(X = si3.fonetic, fields = 1))
# usuario   sistema decorrido 
# 0.31      0.00      0.31

# observar que na coluna 5 existem 183779 linhas com coluna sem valor porem so foi retirada 164476
unix.time(si3.fonetic.notna <- clear.all.matrix(data = si3.fonetic.notna, fields = 2:ncol(si3.fonetic.notna)))
# usuario   sistema decorrido 
# 1.47      0.14      1.61 

# unix.time(si3.fonetic.notna <- listNotNa(X = si3.fonetic, fields = 5))
# usuario   sistema decorrido 
# 0.25      0.05      0.29 
# partindo do indice 5 retiramos 183779 linhasnulas

# unix.time(si3.fonetic.notna <- clear.all.matrix(data = si3.fonetic.notna, fields = (ncol(si3.fonetic.notna)-1):1))
# usuario   sistema decorrido 
# 2.43      0.10      2.54 


# nrow(si3.fonetic.notna) #990508
# sapply(1:ncol(si3.fonetic.notna), function(i) nrow(si3.fonetic.notna[is.na(si3.fonetic.notna[, i]), ]))
# ?clear
# SOAR::Ls()
Ls() # alias para a funcao SOAR::Ls()

# sapply(1:ncol(si3.fonetic.notna), function(i) nrow(si3.fonetic.notna[is.na(si3.fonetic.notna[, i]), ]))
# sapply(4, function(i) nrow(si3.fonetic.notna[is.na(si3.fonetic.notna[, i]), ]))


# nrow(si3.fonetic.notna[is.na(si3.fonetic.notna[, 3]), ]) #2:22145 #183779 1177129 - (22145 + 183779)
# sapply(1:ncol(si3.fonetic.notna), function(i) nrow(si3.fonetic.notna[is.na(si3.fonetic.notna[, i]), ]))
# nrow(si3.fonetic.notna) 1177129 - 990508 = 186621

row.names(x = si3.fonetic.notna) <- 1:nrow(si3.fonetic.notna)
id.si3.notna <- c(1:nrow(si3.fonetic.notna)) #as.integer(row.names(x = si3.fonetic.notna))

cbind(si3.fonetic.notna[66:150, c(3)], si3.fonetic.notna[id.si3.notna[66:150], c(3)])

dedup.si3.fonetic <- RecordLinkage::compare.dedup(dataset = si3.fonetic.notna, blockfld = list(1,2), strcmp = T, identity = id.si3.notna)

dedup.si3.fonetic <- RecordLinkage::compare.dedup(dataset = si3.fonetic.notna[1:5000, ], blockfld = list(1,2,3,4,5), strcmp = T, identity = id.si3.notna[1:5000])

# par si3 fonetizado
psi3.fon <- dedup.si3.fonetic$pairs

# psi3.fon[psi3.fon[, 8] == 1, ]

# comparacao entre o sexo dos pares totalmente correspondente e a data de nasc maior que 79%
psi3.fon[psi3.fon[, c(3)] > 0.9 & psi3.fon[, c(4)] > 0.79, ]
psi3.fon[psi3.fon[, c(3)] > 0.9 & psi3.fon[, c(4)] > 0.79 & psi3.fon[, c(5)] > 0.75, ]
nrow(subset(psi3.fon, PACB_TP_SEXO > 0.7 & PACI_DT_NASC > 0.8 & PACB_CF_NM_COM > 0.7 & PACB_CF_NM_PRI_ULT > 0.6))

# teste para verificar se a biblioteca esta funcionando
# dupliquei a tabela si3 com as 1000 primeiras linhas
test.duplicated <- rbind(si3.fonetic.notna[1:500, ], si3.fonetic.notna[1:500, ])
test.duplicated[1, ]
test.duplicated[501, ]

test.psi3 <- RecordLinkage::compare.dedup(dataset = test.duplicated, blockfld =  list(1,2,3,4,5),  strcmp = T, identity = id.si3.notna[1:1000])
test.psi3$pairs[test.psi3$pairs[, 8] == 1]
nrow(subset(test.psi3$pairs, (PACB_TP_SEXO > 0.89) & (PACI_DT_NASC > 0.89) & (PACB_CF_NM_COM > 0.89)))


data(RLdata10000)

rl1 <- RecordLinkage::compare.dedup(dataset = RLdata10000, blockfld =  list(1,3,5,6,7),  strcmp = T, identity = identity.RLdata10000)
identity.RLdata10000
# cn  <- colnames(x = test.psi3$pairs[, 4:ncol(test.psi3$pairs)-1])
# remove aspas
# cat(cn)






