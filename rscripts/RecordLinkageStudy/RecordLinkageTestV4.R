# http://artax.karlin.mff.cuni.cz/r-help/library/RecordLinkage/html/00Index.html
library(RecordLinkage)

cp.500 <- RLdata500
id.cp30 <- row.names(cp.500[1:30, ])

cp.500[1:30, c(1, 5:7)]

#p1 <- RLBigDataDedup(dataset = cp.500[1:30, ], identity = id.cp30, blockfld = list(1, 5:7), strcmp = T)
p1 <- RLBigDataDedup(dataset = cp.500[1:30, ], identity = id.cp30, blockfld = list(1, 3), strcmp = 1:4)

s2 <- sample(x = 1:30, size = 20)
# ligando duas bases
# estilo cpp RecordLinkage::
p2 <- RLBigDataLinkage(
    dataset1 = cp.500[1:30, ],
    dataset2 =  RLdata500[s2, ],
    identity1 = row.names(cp.500[1:30, ]),
    identity2 = row.names(RLdata500[s2, ]),
    phonetic = 1:4,
    exclude = "lname_c2"
)
# HEINZ novamente
cp.500[c(34, 111), ]
# http://stackoverflow.com/questions/7293029/problem-with-r-package-recordlinkage
compare.dedup(cbind(a=c(1,1,1), b=c(2,0,2), c=c(1,2,1)), identity=c(1,2,3))$pair
compare.dedup(dataset = cp.500[c(34, 111), c(1, 5:7)], blockfld = list(1), identity = c(34, 111))
compare.dedup(dataset = cp.500[c(34, 111), ], blockfld = list(1), identity = c(34, 111))


#p3 <- compare.dedup(dataset = cp.500, identity = row.names(cp.500), blockfld = c(1, 3, 7), strcmp = T)
#p3 <- compare.dedup(dataset = cp.500, identity = row.names(cp.500), blockfld = c(1, 7), strcmp = T, exclude = c("fname_c2", "lname_c1", "lname_c2"))
# p3 <- compare.dedup(dataset = cp.500,
#                     identity = identity.RLdata500, #row.names(cp.500),
#                     blockfld = c(1, 7),
#                     strcmp = T)

p3 <- compare.dedup(dataset = cp.500,
                    identity = identity.RLdata500, #row.names(cp.500),
                    blockfld = c(1, 7),
                    strcmp = T,
                    exclude = c("fname_c2", "lname_c1", "lname_c2"))
#p3$pairs
write.table(x = p3$pairs, file = "p3-pairs.csv", sep = ";", row.names = F, col.names = T)
# p3 <- compare.dedup(
#     dataset = cp.500,
#     identity = row.names(cp.500),
#     blockfld = c(1, 7),
#     exclude = c("fname_c2", "lname_c1", "lname_c2"),
#     n_match=30,
#     n_non_match=100
# )
nrow(p3$pairs)

# com o sem as.chareacter ao muda nada
# com o blocfld reduz o resultado de 130 para 58 linhas em rpairs$pairs igual de p3$pairs
rpairs=compare.dedup(RLdata500,identity=as.character(identity.RLdata500), blockfld = c(1, 7), n_match=30,n_non_match=100)
as.character(identity.RLdata500) == 1
rpairs=compare.dedup(RLdata500,identity=as.character(identity.RLdata500), strcmp = T, exclude = c("fname_c2", "lname_c1", "lname_c2"))
nrow(rpairs$pairs)

# classificacao supervinisonada
# se usar strcmp no metodo compare.dedup eh lancado um warning

# Warning message:
#     In RecordLinkage::getMinimalTrain(rpairs = p3) :
#     Comparison patterns in rpairs contain string comparison values!

mtrain <- RecordLinkage::getMinimalTrain(rpairs = p3)
#mtrain$pairs
write.table(x = mtrain$pair, file = "mtrain.csv", sep = ";", row.names = F, col.names = T)

p4 <- RLBigDataDedup(dataset = cp.500,
                     blockfld = c(1,7),
                     identity = identity.RLdata500,
                     strcmp = T,
                     exclude = c("fname_c2", "lname_c1", "lname_c2"))

classificacao <- RecordLinkage::trainSupv(mtrain, "rpart", minsplit = 2)
resultado <-  RecordLinkage::classifySupv(model = classificacao, newdata = p4)

showClass("RLResult")
RecordLinkage::getTable(resultado)

pairs.resultado <- RecordLinkage::getPairs(object = resultado)
pairs.falsepos <- RecordLinkage::getFalsePos(object = resultado)
pairs.falseneg <- RecordLinkage::getFalseNeg(object = resultado)
pairs.false <- RecordLinkage::getFalse(object = resultado)


errors <- RecordLinkage::getErrorMeasures(object = resultado)








