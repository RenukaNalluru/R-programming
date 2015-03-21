setwd(dir = "C:/Users/christoffer/Desktop/R-programming/")

# carregando funcoes de inicializacao, como load libraries e string de conexao
f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsInitialize.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())
#definindo workdirectory
def.workdirectory(str = "C:/Users/christoffer/Desktop/R-programming/")
# pegando o drive de conexao
drive <- construct.JDBCConnection(driveClass = "oracle.jdbc.OracleDriver", classPath =  paste(getwd(), "/ojdbc6.jar", sep = ""))
# abrindo uma conexao
conn <- def.connection.oracle(drive, str = "jdbc:oracle:thin:@localhost:1521/xe", user = "hr", pwd = "admin")

unix.time(si3.fonetic <- exec.query(conn,  "SELECT * FROM SI3_FONETIC"))
# usuario   sistema decorrido 
#  8.17      0.19      5.79

# carregando um arquivo que contem metodos de utilidades
f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsRecordLinkage.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())

# remover as linhas cuja o campo 1 consta o valor NA
unix.time(si3.fonetic.notna <- listNotNa(X = si3.fonetic, fields = 1))
si3.fonetic.notna[1, ]
# a partir da remocao das linhas cujo campo 1 tinha valor NA, limpe
# remova as demais linhas, agora olhando para os campos de 2 a 5
unix.time(si3.fonetic.notna <- clear.all.matrix(data = si3.fonetic.notna, fields = 2:ncol(si3.fonetic.notna)))

# a biblioteca de record linkage precisa de um vetor cujos valores
# representem cada linha do df (data.frame) "si3.fonetic.notna"
# portanto utilizaremos a quantidade de linhas do df para gerar esse vetor
row.names(x = si3.fonetic.notna) <- 1:nrow(si3.fonetic.notna)
# vetor de ids
id.si3.notna <- c(1:nrow(si3.fonetic.notna))

# ?RecordLinkage::RLBigDataDedup

# cbind(si3.fonetic.notna[1:100, c(1,2,3)], si3.fonetic.notna[id.si3.notna[1:100], c(1,2,3)])

limit <- 1:30000
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
# 15000
# usuario   sistema decorrido 
# 244.80      9.09    258.32
# 15000
# usuario   sistema decorrido 
# 244.80      9.09    258.32
# 30000
# usuario   sistema decorrido 
# 1059.14     37.59   4381.97; 992.45 37.37   1097.19 

unix.time(expr = weight <- RecordLinkage::epiWeights(rpairs = data, e = 0.1, f = RecordLinkage::getFrequencies(x = data), withProgressBar = T))
# 10000
# usuario   sistema decorrido 
# 37.81      1.28     39.19 
# 15000
# usuario   sistema decorrido 
# 92.96      3.19     97.09
# 30000
# usuario   sistema decorrido
# 396.46     31.46    866.69

unix.time(expr = classify <- RecordLinkage::epiClassify(rpairs = weight, threshold.upper = 0.8))
# 1000
# usuario   sistema decorrido 
# 0.13      0.08      0.22 
# 30000
# usuario   sistema decorrido
# 0.92      0.61      1.80

# funcao generica usada para produzir um resumo sobre modelos de dados
# The method invokes particular methods which depend on the object pass by argument
# ?summary

# RecordLinkage::getTable(object = classify)
# summary(RecordLinkage::getTable(object = classify))
# summary(classify)
# ?RecordLinkage::getPairs
unix.time(expr = psi3 <- RecordLinkage::getPairs(object = classify, filter.link = "link"))
# 15000
# usuario   sistema decorrido 
# 5.77      1.14     17.49
# 30000
# usuario   sistema decorrido  
# 24.38     15.85    231.11 

# psi3
# nrow(psi3)
# psi3[1:100, ]
# removendo as linhas brancas do data.frame psi3

unix.time(psi3.not.empty <- psi3[!psi3 == "", ])

write.table(x = psi3.not.empty, file = paste(getwd(), "/rscripts/RecordLinkageStudy/pares_si3.csv", sep = ""), sep = ",")

nrow(psi3.not.empty)

# separando de 2 em dois os pares que a biblioteca gerou,
# como a funcao lapply insere valores nulos na lista, uso a funcao Filter
# para remover
rs <- Filter(f = Negate(f = is.null), x =
    lapply(1:nrow(x = psi3.not.empty), function(i, mod){
        if(i %% mod == 0)
#             psi3.not.empty[(i-1):i, ]
            cbind(psi3.not.empty[(i-1), c(1:4, 7)], psi3.not.empty[i, c(1:4, 7)])
    }, mod = 2)
)

write.table(x = rs, file = paste(getwd(), "/rscripts/RecordLinkageStudy/pares_si3.csv", sep = ""), sep = ",")

as.data.frame(rs)


lapply(rs[1:100], FUN = function(data){
    data <- as.data.frame(data)
    #ifelse(test = data$Weight == 1, yes = data, no = next)
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
