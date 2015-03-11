library(ipred)
library(RecordLinkage)
library(ff)

# stopifnot(library(SOAR))

ri <- integer(10)
fi <- ff(vmode="integer", length = 10)
fb <- ff(vmode="byte", length = 10)

rb <- byte(length(fb))
fb <- ff(rb)

vmode(ri)
vmode(fi)
vmode(fb)
vmode(rb)

str(chunk(fd))
chunk(fd)

memory.limit()



library(RJDBC)
library(sqlutils)

drive <- JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = paste(getwd(), "/ojdbc6.jar", sep = ""), identifier.quote = " ")
con <- dbConnect(drv = drive, "jdbc:oracle:thin:@localhost:1521/xe", "hr", "admin")
si3.fonetic <- dbGetQuery(con,"SELECT * FROM SI3_FONETIC")

# http://mon-ip.awardspace.com/bytes_conversor.php
# format(x = object.size(si3.fonetic),quote = F, units = "MB")
# 117304288 / (1024) # KB mil bytes
# 117304288 / (1024 ^ 2) # MB mil kilobytes
# 117304288 / (1024 ^ 3) # GB mil megabytes
# 117304288 / (1024 ^ 4)

object.size(ls())


# registros que nao possue valor no campo 5 
si3.fonetic[is.na(si3.fonetic[, 5]), ]
si3.fonetic[!is.na(si3.fonetic[, 5]), ]
nrow(si3.fonetic[is.na(si3.fonetic[, 5]), ])
nrow(si3.fonetic)
# sqlexec(connection = "jdbc:oracle:thin:@localhost:1521/xe", sql = "SELECT * FROM SI3_FONETIC")




############################################################################################

# trabalhando com o banco do sistema SIM fonetizado

sim.fonetic <- dbGetQuery(con, "SELECT * FROM SIM_FONETIC")
object.size(x = sim.fonetic) #1093.76 MB
object.size(ls())
# registros que nao possuem valor no campo 5 
# sim.fonetic[is.na(sim.fonetic[, 5]), ]

# transformando os campos SEXO e FO_CD_TODOS_NM em factor
sim.fonetic[, c(1,3)] <- as.factor(sim.fonetic[, c(1,3)])
is.factor(x = sim.fonetic[1:100, 3])

# teste com a biblioteca SOAR
library(SOAR)

source(file = "UtilsRecordLinkage.R")
nrow(sim.fonetic)
sim.fonetic.na <- listNa(X = sim.fonetic, fields = 5)
SOAR::Store(sim.fonetic.na)
nrow(sim.fonetic.na)

# listNa(X = sim.fonetic, fields = c(2, 5))[1:3, ]
# listNotNa(X = sim.fonetic, fields = c(2, 5))[1:3, ]

# nrow(sim.fonetic[sim.fonetic[, 1] == "I", ])
# nrow(sim.fonetic[sim.fonetic[, 1] == "F", ])
# nrow(sim.fonetic[sim.fonetic[, 1] == "M", ])

sim.fonetic.notna <- listNotNa(X = sim.fonetic, fields = 5)
# numero de registros que nao possue nao possuem valor no campo 5
# nrow(sim.fonetic[is.na(sim.fonetic[, 5]), ])
nrow(sim.fonetic.notna) #com o nome da mae: 9696098
SOAR::Store(sim.fonetic.notna)

sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 2)
nrow(sim.fonetic.notna) #com data de nascimento: 9667047

sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 1)
nrow(sim.fonetic.notna) #com sexo: 9667047

sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 3)
nrow(sim.fonetic.notna)# com FO_CD_TODOS_NM #9667047

sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 4)
nrow(sim.fonetic.notna)# com FO_CD_PRI_ULT_NM #9643392

SOAR::Store(sim.fonetic.notna)

id.sim.notna <- as.integer(row.names(x = sim.fonetic.notna))

# attributes(RLdata500)
# levels(x = RLdata500[1, 6])
# attributes(sim.fonetic.notna)
# levels(x = sim.fonetic.notna[, 1])

dedup.sim.fonetic <- RecordLinkage::compare.dedup(dataset = sim.fonetic.notna[1:300, ], blockfld = list(1, 2, 3), strcmp = T, identity = id.sim.notna[1:300])
SOAR::Store(dedup.sim.fonetic)

# analise dos pares que a biblioteca comparou para achar os duplicados
pairs.sim.fonetic <- dedup.sim.fonetic$pairs

pairs.sim.fonetic[pairs.sim.fonetic[, 8] == 1, ]
pairs.sim.fonetic[pairs.sim.fonetic[, c(4)] >= 0.8, ]
pairs.sim.fonetic[pairs.sim.fonetic[, c(4)] >= 0.8 & pairs.sim.fonetic[, c(5)] >= 0.7, ]

sim.fonetic.notna[c(86, 143), ]

nrow(pairs.sim.fonetic[pairs.sim.fonetic[, c(4)] >= 0.8, ])

sim.fonetic.notna[c(4, 183), ]

sim.fonetic.notna[!is.na(sim.fonetic.notna[, 2]), ]
system.time(expr = !is.na(sim.fonetic.notna[, 2]))

listNa(X = sim.fonetic.notna, fields = 2)
listNotNa(X = sim.fonetic.notna, fields = 2)
# fim analise dos pares que a biblioteca comparou para achar os duplicados

rm(list = ls())
ls()
lapply(ls(), function(x) object.size(x))

X <- data.frame(rnorm(1000000*50)) # 381 megabytes
vars <- var(X)
cols <- colMeans(X)
SOAR::Store(X, vars)
SOAR::Store(cols)
SOAR::Store(RLdata500, identity.RLdata500)
find(what = "sim.fonetic")

SOAR::StoreData(sim.fonetic)
SOAR::Store(SOAR::LsData())
SOAR::Ls()      # return objects stored by Soar::Store
objects()
# teste com RLdata

nrow(RLdata500[is.na(RLdata500[, c(1)]), ]) # 0
nrow(RLdata500[is.na(RLdata500[, c(2)]), ]) # 472
nrow(RLdata500[is.na(RLdata500[, c(3)]), ]) # 0
nrow(RLdata500[is.na(RLdata500[, c(4)]), ]) # 492
nrow(RLdata500[is.na(RLdata500[, c(5)]), ]) # 0

#pessoas que possuem o segundo nome mas nao o utlimo
sn.rldata500 <- RLdata500[!is.na(RLdata500[, c(2)]), ]
sn.rldata500[!is.na(sn.rldata500[, c(4)]), ]

#pessoas que possuem o utlimo nome mas nao o utlimo mas nao o segundo
ln.rldata500 <- RLdata500[!is.na(RLdata500[, c(4)]), ]
ln.rldata500[!is.na(ln.rldata500[, c(2)]), ]

# vect <- c(1:10)
# vect[ifelse(test = vect %% 2 == 0, yes = T, no = F)]

?cacheQuery

# https://stat.ethz.ch/R-manual/R-devel/library/utils/html/object.size.html
object.size(x = sim.fonetic) / (1024 ^ 2)
format(x = object.size(x = sim.fonetic), quote = F, units = "MB")
format(x = object.size(x = sim.fonetic), quote = F, units = "auto")


?memory.size    # retorna a atual quantidade de momoria alocada atual ou a maxima
                # pela funcao malloc usada no R, dependendo do parametro max que eh booleano
                # se max = T retorna a maxima quantidade de memoria obtida pelo SO, do contrario
                # retorna a quantidade atualmente usada se NA retorna a quantidade limite

?system.time # retorna o tem que a CPU demorou para processar uma expressao
?unix.time



system.time(x <- runif(1e9) + runif(1E3))
print(x, maxlength=4)

memory.size(max=FALSE)
memory.size(max=TRUE)

system.time(x <- runif(1e7) + runif(1E7))
memory.size(max=FALSE)
memory.size(max=TRUE)
memory.size(max=NA)


