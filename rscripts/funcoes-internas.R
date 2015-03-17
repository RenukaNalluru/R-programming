# testando funcoes
?with
# avalia uma expressao que tenha relacao com uma estrutura de dados
# passada por parametro
with(data = airquality, expr = is.na(Ozone)) # retorna TRUE caso a coluna Ozone tenha 'NA' FALSE caso contrario

?RecordLinkage::epiWeights
?RecordLinkage::getFrequencies
?RecordLinkage::epiClassify
?RecordLinkage::getTable
?RecordLinkage::getPairs
require(stats)
require(graphics)
library(MASS)
?glm
?offset
with(anorexia, {
    ans <- glm(Postwt ~ Prewt + Treat + offset(Prewt), family=gaussian)
    summary(ans)
})

?subset
