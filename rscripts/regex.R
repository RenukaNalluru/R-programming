 
# http://www.r-bloggers.com/regular-expressions-in-r-vs-rstudio/  
# comandos basicos de Regex no R


clean.vect.Regex <- function(pattern = NULL, vect = NULL, ignore = FALSE) {
  if(ignore == FALSE) {
    # usando a funcao grep
    m <- grep(pattern = pattern, x = vect)
    # a funcao retorna um vetor com os indices que correspondem com o padrao (pattern) procurado
    m
  } else {
    m <- grep(pattern = pattern, x = vect, ignore.case = ignore)
    m
  }
}

vectX <- c("16_24cats_dog_cat", "25_34cat", "35_44catch", "45_54Cat", "55_104fat")
str_length(strsplit(vectX, "_")[[1]][2])
length(strsplit(vectX, "_")[[1]])

clean.vect.Regex("cat", vectX)      #ans: [1,2,3]
# TRUE == T retorna verdadeiro
clean.vect.Regex("cat", vectX, T)    #ans: [1,2,3,4]

# cifrão indica que o termo em questão está no final da expressão
clean.vect.Regex("cat$", vectX, T)   #ans: [1,2,4]
clean.vect.Regex("cats", vectX, T)

# funcao grepl retorna um vetor relativo ao veotr passado para funcao.
# o vetor de retorno terá como contudo TRUE ou false em cada indice
# conforme eh achado correspondencia entre o conteudo do veor e o pattern
grepl("cats", vectX, T)

vect_split <- strsplit(vectX, "_")


# usar colchetes(square brackets) como funcao
# http://stackoverflow.com/questions/19260951/using-square-bracket-as-a-function-for-lapply-in-r
# http://stackoverflow.com/questions/11306858/documentation-of-squared-bracket-function

length(vect_split)
length(vect_split[[1]])

# procurar qual foi a string mais quebrada dentro da lista
max(sapply(X = vect_split, FUN = "length"))


sapply(X = strsplit(vectX, "_"), FUN =  "[", ... =  1:max(sapply(X = vect_split, FUN = "length")))

# obtendo o mesmo resultado a partir da funcao str_split_fixed do pacote stringr
library(stringr)
str_split_fixed(vectX, "_", 2)[, 2]
str_split_fixed(vectX, "_", 2)
str_split_fixed(vectX, "_", max(sapply(X = vect_split, FUN = "length")))[1, 2]

str_split_fixed(vectX, "_", n = max(sapply(X = vect_split, FUN = "length")))


# finding and replace strings
# procura e troca a primeira ocorrencia do padrao
sub(pattern = "l", replacement = "y", x = "hello")  # saida: heylo
# procura e troca todas as ocorrencias
gsub(pattern = "l", replacement = "y", x = "hello") # saida: heyyo

# "16_24cats_dog_cat", "25_34cat", "35_44catch", "45_54Cat", "55_104fat"
# claramente as funcoes abaixo produzirao saidas diferentes
gsub(pattern = "cat$", replacement = "fat", x = vectX)
gsub(pattern = "cat$", replacement = "fat", x = vectX, ignore.case = T)

# pegar ocorrencias de 2 numeros seguido de um caracter alfabetico
# que tenha um , mas so se o prmeiro digito dos 2 digitos seguidos for <= a 3
gsub(pattern = "([1-3][1-9][a-z])", replacement = "m\\1", x = "16_24cats_dog_cat", perl = T)

gsub(pattern = "([1-3][1-9][a-z])", replacement = "m\\1", x = vectX, perl = T)
gsub(pattern = "([1-3][1-9][a-z])", replacement = "m\\1", x = vectX, perl = F)
gsub(pattern = "[1-3][1-9][a-z]", replacement = "m\\1", x = vectX, perl = T)



#http://www.r-bloggers.com/making-regex-examples-work-for-you/
#http://www.regular-expressions.info/rlanguage.html
#https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html

#regex e pattern matching

# https://stuff.mit.edu/afs/sipb/project/r-project/lib/R/library/base/html/grep.html
# https://bioinfomagician.wordpress.com/2013/11/03/regular-expression-tutorial-2-commands-in-r/
# http://biostat.mc.vanderbilt.edu/wiki/pub/Main/SvetlanaEdenRFiles/regExprTalk.pdf
