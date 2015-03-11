# http://www.r-bloggers.com/handling-large-csv-files-in-r/
# http://stackoverflow.com/questions/3347375/cache-expensive-operations-in-r
# http://stackoverflow.com/questions/18950249/reading-the-old-data-by-r-from-the-some-kind-of-cache
# http://stackoverflow.com/questions/25425280/can-i-cache-data-loading-in-r
# http://ff.r-forge.r-project.org/bit&ff2.1-2_WU_Vienna2010.pdf

file.sim_fonetic <- paste(getwd(), "/../Desktop/Linkage/SIM_fonetic.csv", sep = "");
file.exists(file.sim_foneti)


file.si3_fonetic <- paste(getwd(), "/../Desktop/Linkage/SI3_fonetic_virgula.csv", sep = "");
file.exists(file.si3_fonetic)

# metodo read.table.ffdf do pacote ff
table <- read.table.ffdf(file = file, first.rows = 500)
table.frame <- data.frame(table)
table.frame[4873, ]


# testando pacote ff

# Pacote disponibiliza estruturas de dados atomicos que sao armazenados no disco mas comportam-se quase
# como se estivessem na memoria ram, com um mapeamento na memoria principal
library(ff)
library(bit)
ff.int <- ff(vmode = "integer", length=10)
ff.byte <- ff(vmode = "byte", length=10)

ff.byte <- ff(initdata = byte(10))

vmode(ff.int)
vmode(ff.byte)

cbind(.rambytes,.ffbytes)[c("integer", "byte"),]
?vmode
.vmode
.vmin
.vmax
.ffmode
.ffbytes

# Exemplo 2
rf <- factor(levels = c("A", "B", "C"))
length(rf) <- 1e3

# Exemplo 3
ff.rf <- ff(rf)
ff.rf[11:1e3] <- NA
ff.rf

# Exemplo 4
?chunk
# criar umma sequencia indexada usando uma sintaxe similar a funcao seq()
chunk.default(from = 1, to = 100, by=5)
args(name = chunk.default)
args(name = chunk.ff_vector)
str(chunk(ff.rf))

# exemplo 6

?runif
rd <- double(100)
rd[] <- runif(100, min = 0, max = 1)

?ff
# While the (possibly packed) raw data is stored on a flat file,
# meta informations about the atomic data structure such as its
# dimension, virtual storage mode  factor level encoding, internal
# length etc.. are stored as an ordinary R object (external pointer
# plus attributes) and can be saved in the workspace

fd <- ff(vmode = "double", length = 1e8)
fd
system.time(expr = for(i in chunk(fd)) fd[i] <- runif(sum(i)))

?quantile
lapply(chunk(fd), function(i)i)
system.time(expr = s <- lapply(chunk(fd), function(i) quantile(fd[i], c(0.05,0.95))))
crbind(s)

# exemplo 1
options(fffinalizer='close')
N <- 1e6 #1e+6 == 1000000
n <- 8e7 #8e+7 == 80000000

generos <- factor(c("F", "M"))
genero <- ff(generos, vmode='quad', length=N, update=F)


for(i in chunk(from = 1, to = n, by =  N)) {
    print(i)
    genero[i] <- sample(generos, sum(i), T)
}
genero[2001]

# ffsave
# http://www.inside-r.org/packages/cran/ff/docs/ffsave
# salvando arquivos muito grandes

?ffsave
# ffsave(...
#        , list = character(0L)
#        , file = stop("'file' must be specified")
#        , envir = parent.frame()
#        , rootpath = NULL
#        , add = FALSE
#        
#        , move = FALSE
#        , compress = !move
#        , compression_level = 6
#        , precheck=TRUE
# )

# ffsave guarda objetos e arquivos "ff" em um arquivo denominado <file>.RData
# nele estao todos os arquivos  ff's relacionados

n <- 8e4
a <- ff(sample(n, n, T), vmode="integer", length=n, filename="a.ff")
b <- ff(sample(255, n, TRUE), vmode="ubyte", length=n, filename="b.ff")
x <- ff(sample(255, n, TRUE), vmode="ubyte", length=n, filename="x.ff")
y <- ff(sample(255, n, TRUE), vmode="ubyte", length=n, filename="y.ff")
z <- ff(sample(255, n, TRUE), vmode="ubyte", length=n, filename="z.ff")
a

df <- ffdf(x=x,z=z,y=y)
rm(x,y,z)
ffsave.image("b")


ffsave(list = c("a","b"), file = "y", rootpath = getwd())
ffsave(df, add=T, file = "rdata-test", rootpath = getwd())


load(file = "ff.RData")




