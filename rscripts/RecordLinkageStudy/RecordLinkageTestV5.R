# artigo
# Example session for Weight-based deduplication

library(RecordLinkage)
data(RLdata500)

cp.data500 <- RLdata500
id.data500 <- identity.RLdata500
row.names(cp.data500)
pairs.dedup <- compare.dedup(dataset = cp.data500, blockfld = list(c(1,3), c(5,6), c(6,7)), identity = id.data500, strcmp = T)
summary(pairs.dedup)
nrow(pairs.dedup$pairs) # 549
is_match <- pairs.dedup$pairs[pairs.dedup$pairs$is_match == 1, ]
nrow(is_match) # 49


getPairs(pairs.dedup)[1:5, ]

# calculo de peso
pairs.emweight <- emWeights(pairs.dedup)
pairs.by.weight <- getPairs(object = pairs.emweight, 30, 5)
#pairs.by.weight[1:15, ]

pair.em = emClassify(rpairs = pairs.emweight, threshold.upper = 25, threshold.lower = 1)
pair.em$pairs
summary(pair.em)
pairs.possibles <- getPairs(object = pair.em, show="possible", single.rows=F)
pairs.links <- getPairs(object = pair.em, show="links", single.rows=F)
pairs.all <- getPairs(object = pair.em, show="all", single.rows=F)

attributes(pairs.possibles)
pairs.possibles[, c(1,2,3,9,10,11,17)]

