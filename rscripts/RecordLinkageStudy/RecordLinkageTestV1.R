# OOP em R
# http://www.milanor.net/blog/?p=1234
# http://stackoverflow.com/questions/1177926/r-object-identification
# http://stackoverflow.com/questions/9521651/r-and-object-oriented-programming
# http://brainimaging.waisman.wisc.edu/~perlman/R/A1%20Introduction%20to%20object-oriented%20programming.pdf
# http://www.r-project.org/conferences/useR-2004/Keynotes/Leisch.pdf
# http://stat.ethz.ch/R-manual/R-devel/library/methods/html/RClassUtils.html

# aparentemente o pacote RecordLinkage possui uma dependencia com o pacote ff


#rcpp <- library(Rcpp)
rlin <- library(RecordLinkage)
showClass(Class = "RLBigData")          # Virtual Class "RLBigData"
showClass(Class = "RLBigDataDedup")     # Class "RLBigDataDedup" extends RLBigData
showClass(Class = "RLBigDataLinkage")   # Class "RLBigDataLinkage" extends RLBigData

# o pacote vem com dois exemplos de dados
data(RLdata500)
data(RLdata10000)

RLdata500[1, ]
RLdata10000[nrow(RLdata10000), ]
linf <- nrow(RLdata10000) - 10
lsup <- nrow(RLdata10000) 
RLdata10000[linf : lsup, ]

#setwd("C:/Users/christoffer/Documents/rscript/base") 
# construtor para objetos big data.
rpairs1 <- RLBigDataDedup(RLdata500, strcmp = 1:4)
rpairs2 <- RLBigDataDedup(RLdata500, blockfld = list(1,3), strcmp = 1:4)

# RLdata500[471:490, 1:ncol(RLdata500)]
# RLdata500[471:490, c(1, 2, 3, 5, 6, 7)]
# ordened.rldata500 <- RLdata500[order(RLdata500[471:490, ]$fname_c1,  decreasing = F), ]

s1 <- 471:490
# vetor randomico de 1 a 1000 com 100 elementos
s2 <- sample(1:1000, 100)
# c(... = identity.RLdata500[s1],  x = rep(NaN, length(s2)))[1]
# c(... = identity.RLdata500[s1],  rep(NaN, length(s2)))[31]

# criar um vetor a partir da uniao do vetor "identity.RLdata500[s1]" e um vetor de NaN com
# a quantidade de elementos no vetor s2 criado logo acima
identify2 <- c(identity.RLdata500[s1],  rep(NaN, length(s2))) # o comprimento desse vetor eh length(s1) + length(s2)

# criando um dataset unindo as s1's linhas de RLdata500 com as s2's linhas de RLdata10000
dataset <- rbind(RLdata500[s1, ], RLdata10000[s2, ]) # numero de linhas nrow(RLdata10000[s2, ]) + nrow(RLdata500[s1, ])

#http://www.dummies.com/how-to/content/how-to-sort-data-frames-in-r.html
order.dataset <- dataset[order(dataset$fname_c1, dataset$lname_c1,  decreasing = F), ]

sub.dataset <- order.dataset[87:90, ]
identify2 <- c(identity.RLdata500[87:90])

rpairs3 <- RLBigDataLinkage(RLdata500, sub.dataset, 
                            identity1 = identity.RLdata500, identity2 = identify2, phonetic = 1:4,
                            exclude = "lname_c2")

train <- getMinimalTrain(compare.dedup(dataset = RLdata500, identity = identity.RLdata500, blockfld = list(1,3)))
rpairs1 <- RLBigDataDedup(RLdata500, identity = identity.RLdata500)
classif <- trainSupv(train, "rpart", minsplit=2)
result <- classifySupv(classif, rpairs1)


#entendendo os metodos do RecordLinkage
odsn <- ncol(order.dataset);

#RLBigDataDedup
RLBigDataDedup(dataset = order.dataset, strcmp = T)
RLBigDataDedup(dataset = order.dataset, strcmp = c(1, 3, 5))

block.list <- list(1, colnames(order.dataset[c(1,3,5,6,7)]))
RLBigDataDedup(dataset = order.dataset, blockfld = block.list)

ans <- RLBigDataDedup(dataset = order.dataset[87:90, ], strcmp = T, blockfld = list(1, c(1, 3, 5)))

sub.order.dataset <- order.dataset[87:90, ]




#pegar os nomes das colunas de um data.frame colnames(order.dataset)
identity.RLdata500
RLdata500[identity.RLdata500, ]
#OOD
#http://www.infoq.com/br/news/2014/05/principios-solid-oo-funcional

#site de pesquisa das classes do R
#http://www.inside-r.org/node/103676