# guia de regex # http://intentor.com.br/pequeno-guia-regex/
# guia de regex # http://www.phpit.com.br/artigos/entendendo-as-expressoes-regulares.phpit

#http://www.r-bloggers.com/making-regex-examples-work-for-you/

#grupos em uma expressao regular
#http://turing.com.br/material/regex/glossary.html#term-grupo
str <- "16_24cats_dog_cat"

cep <- c("000-99999","111-99999", "222-00444", "zzz-cccccc", 
         "222-7107", "723-06080", "010-02345", "xxx-99999",
         "xxxx-99999")
#https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html
p <- c("([1-7])",
       "([0-0]{3})",
       "([0-0][0-0][0-9])",
       "([0-9]){3}",
       "([a-zA-Z]{2})",
       "([a-z]{4}-[6-9])",
       "([0-9]{3}-([9-9]{5}))",
       "([0-9]{3}-[9-9]{5})(-[9-9]{5})", 
       "([0-9]{3}-[9-9]{5})+")

#p[2] significa: [valores entre 0 e 1] que aparecem exatamente 3

str_rep <- "t\\1\\u\\2"

gsub(pattern = p[9], replacement = str_rep, x  = cep, 
     ignore.case = F, perl = T)

grepl(pattern = p[7], x = cep, perl = F)

listn <- c(1000, 1222, 15000)
grepl(pattern = "([0-1]{1})", x = listn)

grepl(pattern = "[a-z]{1,2}", x = c("a", "aaa"))


#http://pt.wikipedia.org/wiki/Express%C3%A3o_regular#Hist.C3.B3ria
#http://aurelio.net/regex/

#http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf
#http://regex.learncodethehardway.org/book/
#http://en.wikibooks.org/wiki/R_Programming/Text_Processing
#
# http://www.regular-expressions.info/rlanguage.html
# http://www.agenciamestre.com/web-analytics/introducao-expressoes-regulares-regex/
# http://turing.com.br/material/regex/introducao.html
# http://turing.com.br/material/regex/glossary.html#term-grupo
# http://www.regular-expressions.info/refcapture.html
# http://aurelio.net/regex/guia/grupo.html

# http://www.phpit.com.br/artigos/entendendo-as-expressoes-regulares.phpit
# http://regex.bastardsbook.com/

readCSV <- function(path = NULL) {
  library(descr)
  if(file.exists(path)) {
      #header <- file.head(path)
      csvFile <- read.table(file = path, header = T, sep  = ";", dec = ",", quote = '"', fill = TRUE)
      csvFile
  }
}

file <- "/rscript/base/SIM_TESTE.csv"
path <- paste(getwd(), file, sep = "");
data <- readCSV(path)

#loop for factor
#https://stat.ethz.ch/pipermail/r-help/2004-January/045192.html
#http://stackoverflow.com/questions/11134812/how-to-find-the-length-of-a-string-in-r

# addresses <- lapply(X = list(levels(x = data$ENDRES)), FUN = function(address){
#   #print(class(nchar(c(address))))
#   #len <- nchar(c(address))
#   address
# })

mapaSigla <- c("av.", "av ", "est.", "faz ", "faz.", "lot ", "pov ", "r ", "r.",
"r:", "tv")

#mat.data <- as.matrix(data)
#mat.data[1,"ENDRES"]



#regex.1 <- "(^av\\.\\s*)"            # comeca com av. e segue com 0 ou mais ocorrencias de espaco(* uso do asterisco) espacos
regex.2 <- "^av\\.\\s{0,}"                # idem
regex.3 <- "^est\\.\\s{0,}"               # idem para "est."


# so sobraram as linhas que possuem endereco
addresses  <- levels(x = data$ENDRES)
matches.av <- lapply(X = addresses, FUN = function(addr) {
  b <- grepl(pattern = regex.2, addr, ignore.case = T)
})

# juntando o vetor de endereco com um vetor de valores booleanos a fim de descobrir quais 
# enderecos comecao com "av."

matrix.av <- cbind(addresses, matches.av)
colnames(matrix.av) <- c("end", "flg")

replaces <- lapply(1:nrow(matrix.av), function(i){
    if(matrix.av[i, ]$flg) {
        t <- sub(pattern = regex.2, replacement = "AVENIDA ", x = matrix.av[i, ]$end, ignore.case = T)
        pairlist(as.integer(i) , t)
    }
})

# trocar av. AVENIDA
for(e in replaces) {
    val <- e[[2]]
    idx <- e[[1]]
    matrix.av[idx, ]$end <- as.character(val)
}


# t <- lapply(replaces, function(e){
#     if( ! is.null(e) ) {
#         val <- e[[2]]
#         idx <- e[[1]]
#         print(idx)
#         matrix.av[idx, ]$end <- as.character(val)
#         #print(matrix.av[idx, ]$end)
#         pairlist(val, idx)
#     }
# })




















#http://stackoverflow.com/questions/1829429/index-value-for-matrix-in-r
#http://stackoverflow.com/questions/12516186/accessing-a-certain-range-of-matrix-elements-in-r
mma.end <- lapply(1:nrow(matrix.av), function(i){
    if(matrix.av[i, ]$flg) {
        end <- matrix.av[i, ]$end;
        end
    }
})

mma.flg <- lapply(1:nrow(matrix.av), function(i){
    if(matrix.av[i, ]$flg) {
        flg <- matrix.av[i, ]$flg
        flg
    }
})

mma <- cbind(mma.end, mma.flg)
mma.end.notnull <- lapply(1:nrow(mma), function(i) {
   if(mma[i, ]$mma.end == NULL)
       
})

# para verificar um elemento especifico quando uso a funcao c()
# data.addresses[120][[1]][1,]$split
# para verificar um elemento especifico quando uso a funcao list()
# data.addresses[[1]][120,]

# data$SK[1]
# class(data$SK[1])
