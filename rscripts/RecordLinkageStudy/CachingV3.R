# novo arquivo para a nova base de dados do SIM
# 05/03/2015


library(ipred)
library(RecordLinkage)
library(ff)
library(RJDBC)
library(SOAR)
SOAR::Ls()

drive <- JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = paste(getwd(), "/ojdbc6.jar", sep = ""), identifier.quote = " ")
con <- RJDBC::dbConnect(drv = drive, "jdbc:oracle:thin:@localhost:1521/xe", "hr", "admin")

unix.time(sim.fonetic <- RJDBC::dbGetQuery(con, "SELECT * FROM SIM_FONETIC"))

SOAR::Store(sim.fonetic)

# carregando um arquivo com funcoes uteis para lidar com data.frame
source(file = "UtilsRecordLinkage.R")
SOAR::Search()

# testando se o campo 3,45,6,7 eh um factor na data.frame
# sim.fonetic[1, ]
# is.factor(x = sim.fonetic[1, c(3,4,5,6,7)]) essa estrategia nao funciona
# is.factor(x = sim.fonetic[1:1000, 4]) funciona mas somente para um campo


# eliminando linhas que nao possuem data de nascimento
unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic, fields = 1))
# usuario   sistema decorrido 
# 3.00      0.25      3.26 
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 80428, sobraram 9931446

# escrevendo o processo de limpeza usando um loop 
clear <- function() {
    #s <- c(c(), nrow(sim.fonetic) - nrow(sim.fonetic.notna))
    for(i in 2:ncol(sim.fonetic.notna) ) { 
        unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = i))
    }
    sim.fonetic.notna
}
unix.time(expr = (sim.fonetic.notna <- clear()))
# usuario   sistema decorrido 
# 33.81      2.14     36.28


# fim eliminar linhas com elementos com valor NA #

# transformar o campo 3,4,5,6,7 do data.frame em factor
# codigo a baixo sera substituido por um loop e o data.frame sim.fonetic
# sera substituido sim.fonetic.notna que nao possui NA
# assim nao existira factor NA
# unix.time(sim.fonetic[, 3] <- as.factor(sim.fonetic[, 3]))
# # # usuario   sistema decorrido 
# # # 27.15      0.44     27.81
# unix.time(sim.fonetic[, 4] <- as.factor(sim.fonetic[, 4]))
# # # usuario   sistema decorrido 
# # # 2.52      0.17      2.68
# unix.time(sim.fonetic[, 5] <- as.factor(sim.fonetic[, 5]))
# # usuario   sistema decorrido 
# # 137.26      0.55    139.18 
# unix.time(sim.fonetic[, 6] <- as.factor(sim.fonetic[, 6]))
# # usuario   sistema decorrido 
# # 47.32      0.39     48.05 
# unix.time(sim.fonetic[, 7] <- as.factor(sim.fonetic[, 7]))
# # usuario   sistema decorrido 
# # 34.17      0.22     34.50 

# tranformando um grupo de campos em factor para usar no record linkage
# unix.time(sapply(3:7, function(i) sim.fonetic[, i] <- as.factor(sim.fonetic[, i] sim.fonetic[, i])))
unix.time(sapply(3:7, function(i){
    sim.fonetic.notna[, i] <- as.factor(sim.fonetic.notna[, i])
    sim.fonetic.notna
}))
# usuario   sistema decorrido 
# 93.22      2.70     97.10
# tempo necessario para fazer o mesmo processo no sim.fonetic
# usuario   sistema decorrido 
# 131.08      2.73    135.07

unix.time(for(i in 3:7){
    sim.fonetic.notna[, i] <- as.factor(sim.fonetic.notna[, i])
})
# tempo usando loop for in
# usuario   sistema decorrido 
# 80.66      2.14     83.33 


# verificando quais colunas sao do tipo factor. Funciona bem
sapply(1:ncol(sim.fonetic.notna), function(i) is.factor(x = sim.fonetic.notna[1, i]))

SOAR::Store(sim.fonetic.notna)

# etapa de limpeza da base SIM_FONETIC

# usar o metodo apply combinado com a funcao que retorna um data.frame sem as linhas
# que possuem pelo menos uma coluna co o campo NA

nrow(sim.fonetic) #10011874
nrow(sim.fonetic.notna) #9637985


nrow(sim.fonetic.notna[sim.fonetic.notna[, 3] == 'F', ]) # I : 2903;  M : 5538564; F : 4096518

# testando se a alguma coluna com algum valor NA
sapply(1:ncol(sim.fonetic.notna), function(i) nrow(sim.fonetic.notna[is.na(sim.fonetic.notna[, i]), ]))

# print(nrow(sim.fonetic) - nrow(sim.fonetic.notna)) # foram retirados no total 373889
# criar um vetor de identificacao para sim.fonetic.notna para usar na bliblioteca de record linkage

# OBSERVAR

row.names(x = sim.fonetic.notnaa) <- 1:nrow(sim.fonetic.notna)
id.si3.notna <- c(1:nrow(sim.fonetic.notna)) 

# verificar se o vetor de id corresponde com os elementos do data.frame
cbind(sim.fonetic.notna[1:100, c(1,2,3,5)], sim.fonetic.notna[id.sim.notna[1:100], c(1,2,3,5)])

dedup.sim.fonetic <- RecordLinkage::compare.dedup(dataset = sim.fonetic.notna[1:300, ], blockfld = list(1, 3, 5, 6, 7), strcmp = T, identity = id.sim.notna[1:300], n_match = 0)
SOAR::Store(dedup.sim.fonetic)
pairs.sim.fonetic <- dedup.sim.fonetic$pairs
SOAR::Store(pairs.sim.fonetic)


pairs.sim.fonetic[pairs.sim.fonetic[, 10] == 1, ]
pairs.sim.fonetic[pairs.sim.fonetic[, c(7)] >= 0.8, ]
pairs.sim.fonetic[pairs.sim.fonetic[, c(7)] >= 0.8 & pairs.sim.fonetic[, c(8)] >= 0.5, ]
pairs.sim.fonetic[pairs.sim.fonetic[, c(3)] >= 0.8 & pairs.sim.fonetic[, c(9)] >= 0.5, ]

sim.fonetic.notna[c(12, 24), ]
sim.fonetic.notna[c(90, 181), ]
sim.fonetic.notna[c(215, 279), ]

###############################################################


