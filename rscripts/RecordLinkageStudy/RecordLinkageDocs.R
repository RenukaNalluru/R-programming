library(RecordLinkage)

data(RLdata500)
data(RLdata10000)

cp.data500 <- RLdata500
id.data500 <- identity.RLdata500
id.data500s <- sort(x = unique(identity.RLdata500), decreasing = F)
id.data10000 <- identity.RLdata10000


# clone
# serialization of record linkage objects

pairs.dp <- compare.dedup(dataset = cp.data500, identity = id.data500,
                          blockfld =list(1, c(1,7)),  #list(1, c(1,7)),
                          strcmp = T, exclude = c("fname_c2", "lname_c1", "lname_c2"))

pairs.dp <- RecordLinkage::compare.dedup(dataset = cp.500, identity = identity.RLdata500,
                          blockfld = c(1, 7), strcmp = T, exclude = c("fname_c2", "lname_c1", "lname_c2"))

pairs.dp$pairs[pairs.dp$pairs[, 7] == 1, ]
# o numero de linhas da sentenca a baixo sera a quantidade de pares correspondentes
# a mesma quantidade que aparecera na variavel result, quando for executado o comando
# summary(classifyUnsup(pairs.dp, method = "bclust"))
nrow(pairs.dp$pairs[pairs.dp$pairs[, 7] == 1, ])
# Classificao com bclust
help(classifyUnsup) # methods "kmeans", "bclust".
bclust <- RecordLinkage::classifyUnsup(pairs.dp, method = "bclust")
kmeans <- RecordLinkage::classifyUnsup(pairs.dp, method = "kmeans")

summary(bclust)
summary(kmeans)

RecordLinkage::getPairs(object = kmeans)[1:10, ]



big.data <- RLBigDataLinkage(dataset1 = cp.data500, dataset2 = RLdata10000[1:300, ], identity1 = identity.RLdata500,identity2 = identity.RLdata10000[1:300],  blockfld = c(1,3), exclude = c("fname_c2", "lname_c2"))
summary(big.data)
getPairs(big.data)


# Saving, loading and deep copying of record linkage objects for big data sets
# parametros: Object(Objeto da classe RLBigData) RLBigDataLinkage extende a RLBigData
# RecordLinkage::clone(object = )
RecordLinkage::clone(object = big.data)
RecordLinkage::getPairs(object = big.data)
setwd(getwd()) #paste(getwd(), "/test", sep = "")
RecordLinkage::saveRLObject(object = big.data, file = "test")

# compare - Comparar resultados
limsup <- 8000
liminf <- 1
bd.comp <- RecordLinkage::compare.linkage(dataset1 = cp.data500, dataset2 = RLdata10000[liminf:limsup, ], blockfld = c(1,3), strcmp = T, exclude = c("fname_c2", "lname_c2"),   identity1 = identity.RLdata500, identity2 = identity.RLdata10000[liminf:limsup])
summary(bd.comp)
RecordLinkage::getPairs(object = bd.comp)







