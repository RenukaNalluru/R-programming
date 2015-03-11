# http://stackoverflow.com/questions/2615128/where-does-r-store-packages
# funcao que imprime local onde os pacotes sao instalados
#.libPaths()

#http://math.usask.ca/~longhai/software/installrpkg.html
#http://www.r-bloggers.com/installing-r-packages/

# use a funcao install.package("package")
# no linux nao vai funcionar se nao tiver acesso do nivel root
install.packages("ggplot2")

# metodo que retorna pacotes instalados
list <- installed.packages()

# instalar sem ter nivel root
# definindo um caminho a partir do workspace R
path <- getwd()
# concatenando o caminho do workspace com o caminho da pasta criada para o pacote baixado
local <- paste(path, "/data/lib-home", sep = "")
# instalando o pacote no local
install.packages(pkgs = "descr", lib = local)

#http://www.dummies.com/how-to/content/how-to-install-load-and-unload-packages-in-r.html
#carregando a biblioteca de um local especifico
library(package = descr, lib.loc = local)

# usemos a biblioteca para testar se foi carregada, vamos ler um arquivo csv
f <- paste(path, "/livro-r-para-cientistas-sociais/RExcel/RparaCS-dados/bd_exemplo2.csv", sep = "")
headerFile <- file.head(file = f)

# fim http://www.r-bloggers.com/installing-r-packages/
# como ver copyright dos pacotes http://stackoverflow.com/questions/23594266/r-package-kernsmooth-copyright
#rs <- library(KernSmooth)

# verificar se um pacote ja esta instalado
isInstalled <- function(pack) {
  if(! require(pack, quietly = TRUE,  character.only = TRUE) )
    FALSE
  else
    TRUE
}
f <- isInstalled("descrp")

# operador ternario, vetorization
# http://stackoverflow.com/questions/8790143/does-the-ternary-operator-exist-in-r

isInstalledV2 <- function(pack) {
  rs <- ifelse( require(pack, character.only = TRUE), TRUE, FALSE)
  rs
}
isInstalledV2("KernSm")

#diferenca entre require(...) e library(...)
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/library.html
