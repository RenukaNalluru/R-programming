library(RecordLinkage)

# vamos entender o peso atributo pela biblioteca RecordLinkage

# primeiro com o metodo dedup
# algumas descubertas:
#
#     se nao for usado o atributo identity os pares duplicados
#     que serao listados no data.frame denominado $pair, terao na
#     coluna is_match o resultado NA, o que dificultara na identificacao
#     do que a biblioteca considerou como par perfeito.

deduplicate.table <- RecordLinkage::compare.dedup(dataset = RLdata500, blockfld = list(1,3,5,6,7), strcmp = T, identity = identity.RLdata500)

# excluindo os campos ("fname_c2", "lname_c2") porque a maioria nao tem
deduplicate.table <- RecordLinkage::compare.dedup(dataset = RLdata500, blockfld = list(1,3,5,6,7), strcmp = T, identity = identity.RLdata500, exclude = c(2, 4))
pairs.ddp <- deduplicate.table$pairs
nrow(pairs.ddp)

source(file = "UtilsRecordLinkage.R")

# deduplicate.table$pairs[deduplicate.table$pairs[, 10] == 1, ]
# RLdata500[c(158, 229), ]

# retirar linhas que possui algum campo NA
table.is_not_na <- listNotNa(X = pairs.ddp, fields = c(4))
nrow(table.is_not_na)

# metodo retorna uma data.frame a partir de outra passada por pametro
table.is_match <- listFieldsByCriteria(X = pairs.ddp, fields = c(8), criteria = c(1) )
nrow(table.is_match)
table.is_match <- listFieldsByCriteria(X = table.is_not_na, fields = c(8), criteria = c(1) )
nrow(table.is_match)

# lista um data.frame pelos campos indicados por parametro
# se os campos nao forem indicados, todos serao listados
# listByFields(X = pairs.ddp)


# pegar os elementos que nao correspondem
# m <- as.matrix(table.is_match)
# t <- apply(X = m[, 1:2], MARGIN = 2, FUN = function(e, a){
#     #(pairs.ddp[85:100,  1:2] == c(e))
#     cbind(a$id1, a$id2)
# }, a = pairs.ddp[85:100, ])


# tabela com os individuos que apesar de alguma semelhanca nao foram identificados como pares pela biblioteca
# lembrar que essa tabela tem apenas 500 pares
table.isn_match <- listFieldsByCriteria(X = pairs.ddp[1:500, ], fields = c(8), criteria = c(0) )

# calculando a media dos campos nome [fname_c1  lname_c1 by bm bd]
# OBS: o resultado que volta tabela pairs no campo is_match eh o mesmo que o metodo apply.mean
# o que permite afirmar que os campos escolhidos nos metodos dedup sao utilizados para um calculo de media
# de um data.frame que segundo a biblioteca de RL tais nomes existem
# forma duplicada
mean.is_match <- apply.mean(table = table.is_match, fields.mean = c(3,4,5,6,7), fields.bind = c(1,2,8))
c(min(mean.is_match[, c("mean")]), max(mean.is_match[, c("mean")]))
# mean.is_match[, 4] == min(mean.is_match[, 4])
# m.equal[as.integer(m.equal[1:2, ]), ]


# calculando a mesma media com os mesmos campos acima, porem da tabela cujo os pares nao correspondem
mean.isn_match <- apply.mean(table = table.isn_match, fields.mean = c(3,4,5,6,7), fields.bind = c(1,2,8))
c(min(mean.isn_match[, c("mean")]), max(mean.isn_match[, c("mean")]))
#options("scipen"=999, "digits"=7)
mean.isn_match[mean.isn_match[, 4] > min(mean.is_match[, 4]), ]


# um par com media alta que nao esta incluso entre os pares corrspondentes
pairs.ddp[280, ]
# um par com media mais baixa que o par acima porem foi incluso entre os correspondentes
pairs.ddp[14949, ]
pairs.ddp[14294, ]
rbind(pairs.ddp[280, ], pairs.ddp[14949, ])

# analisemos qual campo eh mais importante para 


# id1: id do primeiro elemento na comparacao
id1 <- c(as.data.frame(mean.is_match)$id1)
# id2: id do segundo elemento na comparacao
id2 <- c(as.data.frame(mean.is_match)$id2)
# porcentagem de correspondencia entre elemento 1 e 2
mean <- c(as.data.frame(mean.is_match)$mean)
# criar uma tabela para analise
# cbind(id1,id2)

# RLdata500[id1, c(1, 3)]
# RLdata500[id2, c(1, 3)]
RLdata500[c(id1,id2), ]
# uma matriz com os nomes dos pares correspondentes e seus percentuais de correspondencia

fields <- c(1, 3, 5, 6, 7)
#fields <- c(1, 3)
#cbind(RLdata500[id1, fields], RLdata500[id2, fields], id1, id2, mean)

relation <- cbind(RLdata500[id1, fields], RLdata500[id2, fields], id1, id2, mean = sub(pattern = "\\.", replacement = ",", x = mean))
write.table(x = as.matrix(x = relation), file = "RLdata500.is_match.csv",  quote = T, sep = ";", na = "0", dec = ",", row.names = F)


# comparemos agora somente com os pares que sao correspondentes
# http://stackoverflow.com/questions/20295787/how-can-i-use-the-row-names-attribute-to-order-the-rows-of-my-dataframe-in-r
rl500.ordened <- RLdata500[sort(as.integer(row.names(RLdata500[c(id1, id2), ])), decreasing = F), ]
RLdata500[sort(c(id1,id2)), ]

# comparar usando a base de dados original e um identificador
comp.pair.match <- RecordLinkage::compare.dedup(dataset = RLdata500, blockfld = list(1,3,5,6,7), strcmp = T, exclude = c(2, 4), identity = identity.RLdata500)
# com o identificador a tabela de pares volta com a coluna is_match com valores decimais

# idem ao de cima porem sem o identificador
comp.pair.match <- RecordLinkage::compare.dedup(dataset = RLdata500, blockfld = list(1,3,5,6,7), strcmp = T, exclude = c(2, 4))
# sem o identificador a tabela de pares volta com a coluna is_match com valores NA

# compara usando a base original sem comparacao de string
comp.pair.match <- RecordLinkage::compare.dedup(dataset = RLdata500, blockfld = list(1,3,5,6,7), strcmp = F, exclude = c(2, 4), identity = identity.RLdata500)
# sem o uso de comparacao de string, a respota para a comparacao eh binaria, 0 ou 1
# usando a comparacao de strings o resultado varia de 0 a 1

# comparar utilizando uma base de dados que contem somente os id que em outra analise deram correspondencia
# ou seja essa tabela tem q ter correspondencia entre os elementos que a formam
# comp.pair.match <- RecordLinkage::compare.dedup(dataset = RLdata500[sort(c(id1,id2)), ], blockfld = list(1,3,5,6,7), strcmp = T)

#d<-RLdata500[sort(c(id1,id2)), ]
d<-RLdata500[c(id1,id2), ]
d[row.names(x = d), ]
row.names(x = d) <- 1:length(c(id1,id2))
# teste: parametro identify
#
# o data.frame "d" tem a row.name baseada nos id no vetor "c(id1,id2)" [2  25  34  37  48  50]
# isso causa um problema, se observarmos o vetor, o indice 1 tem o valor 2, 2 = 25 ...
# Recapitulando, eh necessario passar um vetor para o parametro identify nos metodos da biblioteca RecordLinkage
# esse vetor precisa ter os numeros correspondentes com o row

# teste simples com a base com pessoas que foram encontradas no metodo dedup aplicado na base RLdata500
comp.pair.match <- RecordLinkage::compare.dedup(dataset = d, blockfld = list(1,3,5,6,7), exclude = c(2, 4))
comp.pair.match$pairs[comp.pair.match$pairs[, "id1"] == 3, ]
table.is_match


comp.pair.match <- RecordLinkage::compare.dedup(dataset = d, blockfld = list(1,3,5,6,7), strcmp = T, exclude = c(2, 4))

comp.pair.match <- RecordLinkage::compare.dedup(dataset = d, blockfld = list(1,3,5,6,7), strcmp = T, identity = 1:length(c(id1,id2)), exclude = c(2, 4))


comp.pair.match$pairs[comp.pair.match$pairs[, "id1"] == 3, ]
d[c(3,53), ]

# fim teste: parametro identify


comp.pair.match$pairs[comp.pair.match$pairs[, "id1"] == 25, ]
RLdata500[c(25,107), ]



as.matrix(x = relation)

# table.is_match
# RLdata500[c(2, 7), ] 
# RLdata500
# RLdata500[c(id1, id2), ]
# sort(c(id1,id2))


# verificar
copy.rlData500 <- RLdata500
copy.id.rld500 <- identity.RLdata500












# gerando csv's http://stackoverflow.com/questions/7484325/remove-index-column-in-write-csv
# write.table(x = RLdata10000, file = "RLdata10000.csv", quote = T, sep = ";", na = "0",row.names = F)
# write.table(x = RLdata500, file = "RLdata500.csv", quote = T, sep = ";", na = "0", row.names = F)

# fazer criteirio por criterio no findBtCriteria, a cada criterio retornar um data.farme e processa-lo
# deduplicate.table$pairs[!is.na(deduplicate.table$pairs[, c(4)]) && deduplicate.table$pairs[, c(10)] == 1, ]
# deduplicate.table$pairs[!is.na(deduplicate.table$pairs[, 4]), ]
