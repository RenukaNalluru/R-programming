library(ipred)
library(RecordLinkage)
library(RSQLite)
library(ff)
library(RJDBC)
library(SOAR)

setwd(dir = "C:/Users/christoffer/Desktop/R-programming/")
drive <- JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = paste(getwd(), "/ojdbc6.jar", sep = ""), identifier.quote = " ")
conn <- RJDBC::dbConnect(drv = drive, "jdbc:oracle:thin:@localhost:1521/xe", "hr", "admin")
# sql <- "SELECT * FROM SI3_FONETIC where rownum < 2000"
sql <- "SELECT * FROM SI3_FONETIC"
unix.time(si3.fonetic <- RJDBC::dbGetQuery(conn, sql))
# usuario   sistema decorrido 
# 5.91      0.29      6.19

install.packages("R.cache")
library(R.cache)

#(C:\Users\CHRIST~1\AppData\Local\Temp\RtmpAvHBJ6

nrow(si3.fonetic) #1177129

f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsRecordLinkage.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())

unix.time(sapply(1:ncol(si3.fonetic), function(i) nrow(si3.fonetic[is.na(si3.fonetic[, i]), ])))
# 0  22145      0      0 183779
# user  system elapsed 
# 1.46    0.06    1.51

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

unix.time(
    dedup.si3.fonetic <- RecordLinkage::compare.dedup(
        dataset = si3.fonetic.notna[1:3000, ],
        blockfld = list(1, 3),
        strcmp = T,
        identity = id.si3.notna[1:3000])
)

# blockfld = list(1) e si3.fonetic.notna[1:1000, ]
# user  system elapsed 
# 8.14    0.09    8.38
# nrow(dedup.si3.fonetic$pairs) 233728

# blockfld = list(1) si3.fonetic.notna[1:2000, ]
# user  system elapsed 
# 30.00    0.47   30.75
# nrow(dedup.si3.fonetic$pairs) 943977

# blockfld =  list(1, 3) si3.fonetic.notna[1:2000, ]
# user  system elapsed 
# 19.42    0.15   19.94

# si3.fonetic.notna[1:3000, ]
# user  system elapsed 
# 66.35    1.92   69.81 
# 2093632

#dedup.si3.fonetic <- RecordLinkage::compare.dedup(dataset = si3.fonetic.notna[1:5000, ], blockfld = list(1,2,3,4,5), strcmp = T, identity = id.si3.notna[1:5000])

# par si3 fonetizado
psi3.fon <- dedup.si3.fonetic$pairs

# psi3.fon[psi3.fon[, 8] == 1, ]

# comparacao entre o sexo dos pares totalmente correspondente e a data de nasc maior que 79%
psi3.fon[psi3.fon[, c(3)] > 0.9 & psi3.fon[, c(4)] > 0.79, ]
psi3.fon[psi3.fon[, c(3)] > 0.9 & psi3.fon[, c(4)] > 0.79 & psi3.fon[, c(5)] > 0.75, ]
nrow(subset(psi3.fon, PACB_TP_SEXO > 0.7 & PACI_DT_NASC > 0.8 & PACB_CF_NM_COM > 0.7 & PACB_CF_NM_PRI_ULT > 0.6))









#################################################################
#################################################################
#################################################################

# teste para verificar se a biblioteca esta funcionando


#################################################################
#################################################################
#################################################################
#################################################################
#################################################################


# dupliquei a tabela si3 com as 1000 primeiras linhas
test.duplicated <- rbind(si3.fonetic.notna[1:500, ], si3.fonetic.notna[1:500, ])
test.duplicated[1, ]
test.duplicated[501, ]

test.psi3 <- RecordLinkage::compare.dedup(dataset = test.duplicated, blockfld =  list(1),  strcmp = T, identity = id.si3.notna[1:1000])
test.psi3$pairs[test.psi3$pairs[, 8] == 1]
nrow(subset(test.psi3$pairs, (PACB_TP_SEXO > 0.89) & (PACI_DT_NASC > 0.89) & (PACB_CF_NM_COM > 0.89)))

library(RecordLinkage)
data(RLdata10000)
data(RLdata500)
RLdata10000[1,]
RLdata10000[RLdata10000$fname_c1 == "FRANK" & RLdata10000$lname_c1 == "SCHROEDER",]
 
# http://www.cookbook-r.com/Manipulating_data/Finding_and_removing_duplicate_records/
# stackoverflow.com/questions/10769640/how-to-remove-repeated-elements-in-a-vector
sorted <- unique(sort(identity.RLdata10000, decreasing = F))
# sorted[!sorted %in% c(0)][1:100]

cbind(RLdata10000[1:100, c(1,3,5)], RLdata10000[sorted[!sorted %in% c(0)][1:100], c(1,3,5)])


# limite
# ?RecordLinkage::compare.dedup
# range <- 1:length(sorted[!sorted %in% c(0)])
# rl1 <- RecordLinkage::compare.dedup(dataset = RLdata10000[range, ], blockfld =  list(1,3,5),  strcmp = T, identity = range)

#{1,3,5,6,7}

unix.time(rl1<-RecordLinkage::compare.dedup(dataset = RLdata10000, blockfld =  list(1, 3, 5, 7),  strcmp = T, identity = identity.RLdata10000))
# tempo gasto com os campos (1, 5, 7)
# usuário   sistema decorrido 
# 72.94      1.26     74.86 

unix.time(rl5<-RecordLinkage::compare.dedup(dataset = RLdata500, blockfld =  list(1, 3, 5, 7),  strcmp = T, identity = identity.RLdata500))
gc(verbose = T)
rm(list=ls(all.names = T))
gcinfo(TRUE)
nrow(rl1$pairs[rl1$pairs$is_match == 1,  ]) # {1:658; (1, 3):992; (1,3,5):997; (1,5,7):999, }
nrow(rl5$pairs[rl5$pairs$is_match == 1,  ]) # {1:34; (1, 3):49, (1,3, 5, 7):50}


unix.time(ans<-RecordLinkage::RLBigDataDedup(dataset = RLdata10000, identity = identity.RLdata10000, blockfld = list(1,5,7), strcmp = T))
# tempo gasto com os campos (1, 5, 7)
# usuário   sistema decorrido 
# 16.69      0.69     22.80
# ?epiWeights
# class(ans)
# ?RecordLinkage::getFrequencies(x = ans)

unix.time(ans <- RecordLinkage::epiWeights(rpairs = ans, f = RecordLinkage::getFrequencies(ans)))
# usuário   sistema decorrido 
# 4.74      0.39      5.14
# class(ans)
# ?epiClassify

################## Teste 1 com epiClassify e getPairs

unix.time(rs <- RecordLinkage::epiClassify(rpairs = ans, threshold.upper =  0.5))
class(rs)
unix.time(table <- RecordLinkage::getTable(rs))
# usuário   sistema decorrido 
# 4.45      0.15      4.61
class(table)
?RecordLinkage::getPairs

summary(RecordLinkage::getTable(object = rs))

## S4 method for signature 'RLResult'
unix.time(pairs <- RecordLinkage::getPairs(object = rs, max.weight = 0.8, filter.link="link"))
# usuário   sistema decorrido 
# 0.46      0.06      0.52 
# class(pairs)
# nrow(pairs) # {
#     com "threshold.upper" do metodo "RecordLinkage::epiClassify" em 0.5
#     com "max.weight" em 0.8
#     foram gerados 590958 pares
#}

pairs[!pairs[1:100, ]$is_match == "", ]
unix.time(RecordLinkage::getFalse(object = rs))
RecordLinkage::getFalseNeg(object = rs)
RecordLinkage::getFalsePos(object = rs)

################### fim Teste 1

################### Teste 2 com epiClassify e getPairs

unix.time(rs <- RecordLinkage::epiClassify(rpairs = ans, threshold.upper =  0.7))
unix.time(pairs <- RecordLinkage::getPairs(object = rs, min.weight = 0.5, max.weight = 0.8, filter.link = "link"))
# usuário   sistema decorrido 
# 0.25      0.06      0.31
# nrow(pairs) # {
#     com "threshold.upper" do metodo "RecordLinkage::epiClassify" em 0.7
#     com "max.weight" em 0.8 min.weight = 0.5
#     foram gerados 2763 pares
# com os mesmos parametros na funcao epiClassify porem mudando o argumento
# filter.match = "match" filter.link = "link" encontrei 2091 pares

#}



?RecordLinkage::getFalse
unix.time(RecordLinkage::getFalse(object = rs))
RecordLinkage::getFalseNeg(object = rs)
RecordLinkage::getFalsePos(object = rs)


################### fim Teste 2

################### Teste 3 com epiClassify e getPairs

unix.time(rs <- RecordLinkage::epiClassify(rpairs = ans, threshold.upper =  0.8))
unix.time(pairs <- RecordLinkage::getPairs(object = rs, min.weight = 0.7, max.weight = 0.8, filter.match = "match"))
# usuário   sistema decorrido 
# 0.25      0.06      0.31
# nrow(pairs) # {
#     com "threshold.upper" do metodo "RecordLinkage::epiClassify" em 0.8
#     com "max.weight" em 0.8 min.weight = 0.7
#     foram gerados 2007 pares

#     com "max.weight" em 0.8 min.weight = 0.7
#     com "max.weight" em 0.9 min.weight = 0.7
#       2238
# threshold.upper =  0.8 min.weight = 0.8, max.weight = 0.9
# 231
#     
#}



?RecordLinkage::getFalse
unix.time(RecordLinkage::getFalse(object = rs))
RecordLinkage::getFalseNeg(object = rs)
RecordLinkage::getFalsePos(object = rs)


################### fim Teste 3

################### Teste 4
unix.time(rs <- RecordLinkage::epiClassify(rpairs = ans, threshold.upper =  0.8))
unix.time(pairs <- RecordLinkage::getPairs(object = rs, min.weight = 0.7, max.weight = 0.8, filter.match = c("match", "unknown", "nonmatch"), filter.link = c("nonlink", "possible", "link")))
# usuario   sistema decorrido 
# 0.22      0.01      0.25
# nrow(pairs) #2091

################### fim Teste 4



# RecordLinkage::getPairs(object = rs) nao exeuctar somente com o parametro object
?RecordLinkage::clear

summary(ans)
# levenshteinDist("AXAX", "CBEEE")
# diferenca de pares resultantes conforme a quantidade de campos no blockfld
rl1.pairs <- rl1$pairs # { {1:472774}, {(1,3):1320853}, {(1,3,5):1929865} }
# cn  <- colnames(x = test.psi3$pairs[, 4:ncol(test.psi3$pairs)-1])
# remove aspas
# cat(cn)






