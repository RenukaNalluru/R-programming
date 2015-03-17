library(ipred)
library(RecordLinkage)
library(RSQLite)
library(ff)
library(RJDBC)
library(SOAR)

setwd(dir = "C:/Users/christoffer/Desktop/R-programming/")
drive <- JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = paste(getwd(), "/ojdbc6.jar", sep = ""), identifier.quote = " ")
conn <- RJDBC::dbConnect(drv = drive, "jdbc:oracle:thin:@localhost:1521/xe", "hr", "admin")
sql <- "SELECT * FROM SI3_FONETIC"
unix.time(si3.fonetic <- RJDBC::dbGetQuery(conn, sql))

# carregando um arquivo que contem metodos de utilidades
f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsRecordLinkage.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())

# remover as linhas cuja o campo 1 consta o valor NA
unix.time(si3.fonetic.notna <- listNotNa(X = si3.fonetic, fields = 1))

# a partir da remocao das linhas cujo campo 1 tinha valor NA, limpe
# remova as demais linhas, agora olhando para os campos de 2 a 5
unix.time(si3.fonetic.notna <- clear.all.matrix(data = si3.fonetic.notna, fields = 2:ncol(si3.fonetic.notna)))

# a biblioteca de record linkage precisa de um vetor cujos valores
# representem cada linha do df (data.frame) "si3.fonetic.notna"
# portanto utilizaremos a quantidade de linhas do df para gerar esse vetor
row.names(x = si3.fonetic.notna) <- 1:nrow(si3.fonetic.notna)
# vetor de ids
id.si3.notna <- c(1:nrow(si3.fonetic.notna))

?RecordLinkage::RLBigDataDedup

# cbind(si3.fonetic.notna[1:100, c(1,2,3)], si3.fonetic.notna[id.si3.notna[1:100], c(1,2,3)])

limit <- 1:10000
unix.time(data <- RecordLinkage::RLBigDataDedup(
    dataset = si3.fonetic.notna[limit, c(1,2,3)], 
    #identity = id.si3.notna[limit],
    blockfld = list(1,2,3),
    strcmp = c(1,2,3)
))
#9500
# usuario   sistema decorrido 
# 81.89      3.13     90.73 
#10000
# usuario   sistema decorrido 
# 99.22      3.58    107.83 

unix.time(expr = weight <- RecordLinkage::epiWeights(rpairs = data, e = 0.1, f = RecordLinkage::getFrequencies(x = data), withProgressBar = T))
#1000
# usuario   sistema decorrido 
# 37.81      1.28     39.19 

unix.time(expr = classify <- RecordLinkage::epiClassify(rpairs = weight, threshold.upper = 0.8))
#1000
# usuario   sistema decorrido 
# 0.13      0.08      0.22 

RecordLinkage::getTable(object = classify)
summary(RecordLinkage::getTable(object = classify))
?RecordLinkage::getPairs
unix.time(expr = psi3 <- RecordLinkage::getPairs(object = classify, filter.link = "link"))

# psi3
# nrow(psi3)
# psi3[1:100, ]
# removendo as linhas brancas do data.frame psi3
psi3.not.empty <- psi3[!psi3 == "", ]
psi3.not.empty[1:100, ]

# separando de 2 em dois os pares que a biblioteca gerou,
# como a funcao lapply insere valores nulos na lista, uso a funcao Filter
# para remover
rs <- Filter(f = Negate(f = is.null), x =
    lapply(1:nrow(x = psi3.not.empty), function(i, mod){
        if(i %% mod == 0)
            psi3.not.empty[(i-1):i, ]
    }, mod = 2)
)

lapply(rs[1:100], FUN = function(data){
    data <- as.data.frame(data)
    ifelse(test = data$Weight == 1, yes = data, no = next)
})

nrow(RecordLinkage::getFalse(object = classify))
nrow(RecordLinkage::getFalsePos(object = classify))

# sapply(1:ncol(si3.fonetic.notna), function(i) nrow(si3.fonetic.notna[is.na(si3.fonetic.notna[, i]), ]))
# list.frame <- list()
# for(i in 1:nrow(x = si3.fonetic.notna[1:100, ])){
#     ifelse(test = (i %% 5 == 0),
#         yes = {
#             list.frame <- list(list.frame, si3.fonetic.notna[(i-4):i, ])
#         },
#         no = print(i)
#     )
# }



# funcao que separa as 990000 linhas em blocos de 9500 em 9500 104
mod = 9500
nrow(x = si3.fonetic.notna) / mod
list.frame <- lapply(1:nrow(x = si3.fonetic.notna), function(i, mod){
    if(i %% mod == 0)
        si3.fonetic.notna[(i-4):i, ]
}, mod)
# http://r.789695.n4.nabble.com/How-to-get-rid-of-NULL-in-the-result-of-apply-td960776.html
list.frame <- Filter(f = Negate(f = is.null), x = list.frame)
length(list.frame)
list.frame[length(list.frame)]

# si3.fonetic.notna[(nrow(si3.fonetic.notna)-264) : (nrow(si3.fonetic.notna)-263), ]
list.frame <- split(si3.fonetic.notna, (1:nrow(si3.fonetic.notna)  %%  9500))
