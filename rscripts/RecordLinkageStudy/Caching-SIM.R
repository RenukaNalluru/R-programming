setwd(dir = "C:/Users/christoffer/Desktop/R-programming/")

# carregando funcoes de inicializacao, como load libraries e string de conexao
f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsInitialize.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())

# ?read.table
# ?unlink
# ?unlist

# file.exists(paste(getwd(),"/../Linkage/SIM_PHON.csv",sep = ""))
# unix.time(table <- read.table(file = paste(getwd(),"/../Linkage/SIM_PHON.csv",sep = ""), header = T, sep = ","))
# # usuario   sistema decorrido 
# # 333.47      2.25    352.55
# nrow(table)

drive <- construct.JDBCConnection(driveClass = "oracle.jdbc.OracleDriver", classPath =  paste(getwd(), "/ojdbc6.jar", sep = ""))
# abrindo uma conexao
conn <- def.connection.oracle(drive, str = "jdbc:oracle:thin:@localhost:1521/xe", user = "hr", pwd = "admin")
unix.time(dtsim <- exec.query(conn,  "SELECT * FROM SIM_FONETIC"))
# usuario   sistema decorrido 
# 165.77      2.65    110.00 
# nrow(dtsim) #10011874

# carregando um arquivo que contem metodos de utilidades
f <- paste(getwd(), "/rscripts/RecordLinkageStudy/UtilsRecordLinkage.R", sep = "")
t <- file.exists(f)
ifelse(test = t, yes = source(file = f), no = q())

ncol(dtsim)
# 1 -> 80428, 2 -> 113, 3 -> 0,  4 -> 1, 5 -> 0, 6 -> 49102, 7 -> 321912

# sapply(1:ncol(dtsim), function(i) nrow(dtsim[is.na(dtsim[, i]), ]))
# 80428    113      0      1      0  49102 321912

# remover as linhas cuja o campo 1 consta o valor NA
unix.time(dtsim <- listNotNa(X = dtsim, fields = 1))
# usuario   sistema decorrido 
# 8.81      0.36      9.19


# a partir da remocao das linhas cujo campo 1 tinha valor NA, limpe
# remova as demais linhas, agora olhando para os campos de 2 a 5
unix.time(dtsim <- clear.all.matrix(data = dtsim, fields = 2:ncol(dtsim)))
#9931446, 9931439, 9931439, 9931438, 9931438, 9905048
# usuario   sistema decorrido 
# 44.78      2.14     47.44
nrow(dtsim) #9637985

row.names(x = dtsim) <- 1:nrow(dtsim)
# vetor de ids
id.sim <- c(1:nrow(dtsim))

dtsim[1, ]

limit <- 1:30000
unix.time(data <- RecordLinkage::RLBigDataDedup(
    dataset = dtsim[limit, c(1,2,3)], 
    #identity = id.si3.notna[limit],
    blockfld = list(1,2,3),
    strcmp = c(1,2,3)
))
# 30000
# user  system elapsed 
# 1263.14   39.56 1508.33

unix.time(expr = weight <- RecordLinkage::epiWeights(rpairs = data, e = 0.1, f = RecordLinkage::getFrequencies(x = data), withProgressBar = T))
# user  system elapsed 
# 428.77   39.09  944.30

unix.time(expr = classify <- RecordLinkage::epiClassify(rpairs = weight, threshold.upper = 0.8))
# user  system elapsed 
# 2.27    0.89    3.56

unix.time(expr = psi3 <- RecordLinkage::getPairs(object = classify, filter.link = "link"))
