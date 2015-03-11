library(RecordLinkage)
showClass(Class = "RLBigData")          # Virtual Class "RLBigData"
showClass(Class = "RLBigDataDedup")     # Class "RLBigDataDedup" extends RLBigData
showClass(Class = "RLBigDataLinkage")   # Class "RLBigDataLinkage" extends RLBigData

# o pacote vem com dois exemplos de dados
data(RLdata500)
data(RLdata10000)


pair.rl500.cmpdd <- compare.dedup(RLdata500, blockfld = list(1:2))
# rbind(RLdata500[290, ], RLdata500[466, ])
pair.rl500.cmpdd <- compare.dedup(RLdata500)
pairs <- lapply(X = pair.rl500.cmpdd, function(e){ e })$pairs

colnames(pairs)

lapply(X = pairs, FUN = function(e, a, b){}, a = "id1", b = "id2")

table <- cbind(
    lapply(X = pairs, FUN = function(e){
      e
    })$id1
    ,
    lapply(X = pairs, FUN = function(e){
        e
    })$id2
)


pair.rl500.cmpdd  <- compare.dedup(RLdata500)

RLBigDataDedup(dataset = RLdata500)

lapply(X = as.list.data.frame(RLdata500), function(e) {
    e[1]$lname_c1
})

RLdata500[list(1, c(1:3))]

# RJournal 2010
# Os nomes das colunas sao usados para comparacao de padroes
# nome das linhas sao usadas como identificadores
colnames(RLdata500);

# duas funcoes para a criacao de comparacao de padrao num conjunto de dados
# compare.dedup, procura por duplicatas em um unico conjuno de dados
# compare.linkage: para ligar dois conjuntos de dados

rp <- compare.dedup(dataset = RLdata500,identity = identity.RLdata500)
rp$data[1:5, ]
rp$pairs[1:5, ]

listId1 <- c(rp$pairs[1:5, ]$id1);
listId2 <- c(rp$pairs[1:5, ]$id2);

#rp$data[c(rp$pairs[1:5, ]$id1), ]
#rp$data[c(rp$pairs[1:5, ]$id2), ]
# nomes que foram comparados de 1 a 5 no data.frame RLdata500
cbind(rp$data[listId1, ], rp$data[listId2, ])

# blocagem

#o argumento blockfld deine as colunas que serap separadas em blocos logicos, no processo de blocagem
# a mais ssimples definicao eh um vetor de numeros que denota pos indices das colunas dos atributos
# que dois elementos devem corresponder, possivelmente apois aplicacao do codigo fonetico

# no exemplo abaixo os elementos selecionados se correspondem no primeiuro nome, alguns na data de nascimento
# completamente(ano, mes e dia) e alguns corresponde no primeiro nome e no dia do nascimento
# list(1, 5:7) -> essa lista corresponde as colunas, fname_c1, by, bm, bd
#rp1 <- compare.dedup(RLdata500, blockfld = list(1, 5:7), identify = identity.RLdata500)
rp1 <- compare.dedup(RLdata500, blockfld = list(1, 5:7), identity = identity.RLdata500)
rp1$pairs[c(1:3, 1203:1204), ]

rl500.ordered <- data.frame("index" = 1:nrow(RLdata500), RLdata500[order(RLdata500$fname_c1), ])
#rl10000.ordered <- data.frame("index" = 1:nrow(RLdata10000), RLdata10000[order(RLdata10000$fname_c1), ])
#data.frame(rl500.ordered[c(1,2,3)])
# http://www.ats.ucla.edu/stat/r/faq/subset_R.htm
ss.rl500 <- subset(x = rl500.ordered, rl500.ordered$fname_c1 == c("SABINE"))
ss.rl10000 <- subset(x = rl10000.ordered, rl10000.ordered$fname_c1 == c("SABINE"))
ss.rl500.dup <- rbind(ss.rl500[1, ], ss.rl500)

pairs.ssrl500 <- compare.dedup(dataset = ss.rl500, blockfld = list(2, 6:8), identity = ss.rl500$index)
pairs.ssrl500.dup <- compare.dedup(dataset = ss.rl500.dup,
                                   blockfld = list(2, 6:8),
                                   identity = ss.rl500.dup$index)

obj <- RLBigDataDedup(dataset = ss.rl500.dup, blockfld = list(2, 6:8), identity = ss.rl500.dup$index)

# funcao fonetica: a funcao fonetica e utilizada atraves do argumento phonetic, que aceita um vetor de inteiros
# indicando quais campos do data.frame serao utilizados na fonetizacao.
# a funcao phonetic eh aplicada antes do processo de blocking, portando as restricoes impostas pelo processo
# de blocking sao atraves dos codigos foneticos

pairs.rl500116 <- compare.dedup(dataset = RLdata500[1:16, ],
                               phonetic = 1:4,
                               blockfld = list(1,3),
                               identity = row.names(RLdata500[1:16, ]))

# teste com atributo de fonetizacao num data.frame em ordem alfabetica
rl500.ordered[1:30, ]
row.names(rl500.ordered[1:30, ])



#strcmp: Esse parametro perminte mensurar a similaridade entre string, geralmente
# a similaridade eh medida num limiar de 0 a 1, onde 0 denota disimilizacao maxima
# e uma a igualdade entre as string. Isso permite a comparacao 'fuzzy'

rpairsfz <- compare.dedup(
    dataset = RLdata500,
    blockfld = c(5,6),
    strcmp = T  
)

rpairsfz$pairs[1:20, ]
rpairsfz$data[1:130, ]

copy.rldata500 <- RLdata500
# Heinz Boehm
copy.rldata500[34, ]
#copy.rldata500[34, 1] <- a()

# usando strcmp e blockfld, se os campos escolhidos em blockfld nao forem correspondentes, o argumento strcmp
# que compara os campos como string vai dar um valor zero para esse campo, excluindo a comparacao
# Exemplo: copy.rldata500[34, ] eh # Heinz Boehm, ao inverter o ano de nascimento e usar como campo para blocking
# se houver outro Heinz Boehm, e seus dados forem muito parecidos, a comparacao nao sera feita, pois o ano de nascimento que eh importante foi zerado
rpairsfz <- compare.dedup(
    dataset = copy.rldata500,
    blockfld = c(1, 7),
    strcmp = T  
)
rpairsfz$pairs[1:20, ]
rpairsfz$data[1:130, ]


# Heinz Boehm birth year, invertendo valores
copy.rldata500[34, 5] <- 1938
copy.rldata500[34, 6] <- 21

#inserindo um level novo em RLData500 #levels(copy.rldata500$fname_c1)
#http://stackoverflow.com/questions/11810605/replace-contents-of-factor-column-in-r-dataframe
levels(copy.rldata500$fname_c1) <- c(levels(copy.rldata500$fname_c1), "HEINS", 'HEINV', "HEINZZ")
#copy.rldata500$fname_c1[copy.rldata500$fname_c1 == "HEINZ" && copy.rldata500$bm == 12] <- "HEINS"
# trocando HEINZ por HEINV
copy.rldata500$fname_c1[copy.rldata500$fname_c1 == 'HEINZ'][1] <- 'HEINZZ'
# verificar se houve a troca
copy.rldata500[c(34, 111), ]
# apos a troca de HEINZ para "HEINV", se utilizarmos tal campo (1 no caso) no blockfld
# HEINV nao aparecera no resultado pois o nome nao bate com nenhum nome na base de dados
# ao comparar "HEINZ" com "HEINV" a funcao retorna 0.92 de correspondencia entre as strings
# mas nao eh o suficiente. Ao comparar 'HEINZ' com 'HEINZZ' 0.96, porem mesmo assim nao eh incluido o HEINZ
# algo que permite confirmar que se o resultado nao for 1, a variavel e retirada da comparacao
rpairsfz <- compare.dedup(
    dataset = copy.rldata500,
    blockfld = c(1,7),
    strcmp = T  
)

rpairsfz$pairs[1:30, ]
rpairsfz$data[1:130, ]


#rpairsfz <- compare.dedup(dataset = rl500.ordered, blockfld = c(6,7), strcmp = T)
#rpairsfz$pairs


library(stringdist)
amatch("leia",c("uhura","leela"),maxDist=5)