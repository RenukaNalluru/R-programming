library(RecordLinkage)
showClass(Class = "RLBigData")          # Virtual Class "RLBigData"
showClass(Class = "RLBigDataDedup")     # Class "RLBigDataDedup" extends RLBigData
showClass(Class = "RLBigDataLinkage")   # Class "RLBigDataLinkage" extends RLBigData

# o pacote vem com dois exemplos de dados
data(RLdata500)
data(RLdata10000)

rl500.ordered <- data.frame("index" = 1:nrow(RLdata500), RLdata500[order(RLdata500$fname_c1), ])
rl10000.ordered <- data.frame("index" = 1:nrow(RLdata10000), RLdata10000[order(RLdata10000$fname_c1), ])
#data.frame(rl500.ordered[c(1,2,3)])
# http://www.ats.ucla.edu/stat/r/faq/subset_R.htm
ss.rl500 <- subset(x = rl500.ordered, rl500.ordered$fname_c1 == c("SABINE"))
ss.rl10000 <- subset(x = rl10000.ordered, rl10000.ordered$fname_c1 == c("SABINE"))


ss.rl500 <- ss.rl500[order(ss.rl500$lname_c1), ]
ss.rl10000 <- ss.rl10000[order(ss.rl10000$lname_c1), ]
order(... = sample(x = 1:10, size = 5), decreasing = T)

#ss.rl500 <- rbind(ss.rl500[1, ], ss.rl500)

pair <- compare.dedup(ss.rl500, strcmp = T) 
#pair2 <- compare.dedup(rbind(ss.rl500[1, ], ss.rl500), strcmp = T,  identity = c(300, row.names(ss.rl500)))
pair2 <- compare.dedup(rbind(ss.rl500[1, ], ss.rl500),
                       strcmp = T,
                       identity = rbind(ss.rl500[1, ],
                        ss.rl500)$index)

pair3 <- RLBigDataDedup(rbind(ss.rl500[1, ], ss.rl500), blockfld = list(1, c(2,3,5)))


partition <- apply(X = pair2$pairs, MARGIN = 1, function(e){
    if(e[6] > 0.6111111) {
        e[1:2]
    }
})

rpairs1 <- RLBigDataDedup(rbind(ss.rl500[1, ], ss.rl500), blockfld = list(1,3), strcmp = 1:4)

subset.pair2 <- subset(x = pair2$pairs, pair2$pairs[6] > 0.6111111)
subset.pair2 <- subset(x = subset.pair2, subset.pair2[8] > 0.7333333)


# funcao apply: O argumento MARGIN aceita o valor 1 ou 2
# 1 para aplicar a funcao em FUN as linhas ou 2 as colunas
# rl500.ordered[496:500, c(1,2,6)]
# 
# rldm <- apply(X = rl500.ordered, MARGIN = 1,FUN = function(e) {
#     if( e[2] =="ANJA" )
#         return(data.frame(e[2]))
# })
# rldm <- as.data.frame(x = rldm)



