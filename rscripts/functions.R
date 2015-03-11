# http://adv-r.had.co.nz/Functions.html

# primeira funcao

x <- 10
f1 <- function(x) {
  function() {
    return(x+10)
  }
}
f1(1)()

# Function Components.

# 3 componentes:
# body(), codigo dentro da funcao
# formals(), lista de argumentos que controla como vc pode chamar a funcao
# environment(), o mapa da localizacao das variaveis da funcao

my.exp <- function(x, y) x ^ y
my.exp(2, 3)
rs <- formals(my.exp)
rs <- body(my.exp)
rs <- environment(my.exp)


# Exercicios
# 1.  What function allows you to tell if an object is a function? 
#     What function allows you to tell if a function is a primitive function?
#R:
is.function(x = my.exp)
is.primitive(x = sum)
args()
# 2. This code makes a list of all functions in the base package.
# ls -> List Objects: retorna um vetor de strings, dado o nome de um objeto em um environment
# quando usado sem argumentos eh mostrado um conjunto de dados e funcoes definidas pelo programador
funcs <- ls(name ="package:base")

#mget -> pesquisa por um nome de um, nenhum ou muitos objetos
objs <- mget(x = funcs, inherits = TRUE)

#http://stat.ethz.ch/R-manual/R-devel/library/base/html/formals.html
#http://stat.ethz.ch/R-manual/R-devel/library/base/html/args.html
filtered <- Filter(f = is.function, x = objs)
#as.matrix(filtered)

new_f <- lapply(X = filtered, function(f) { 
  a <- args(f)
  n <- rbind(names(formals(f)))
  #l <- length(names(formals(f)))
  #c(a, n, l)
#   m <- cbind(a, n, l)
#   colnames(m) <- c("func", "args", "len")
#   m
#   if (l == 0) {
#     c(a, n, l)
#   }
    

  #print(class(length(formals(a))))
})

new_f$zapsmall
summary(new_f[1000:1010])
rm(new_f)

# lapply(X = filtered, function(name){
#   print(name)
# })
# 
# summary(filtered)




# Which base function has the most arguments?
# 
# How many base functions have no arguments? What's special about those functions?
# 
# How could you adapt the code to find all primitive functions?



#perguntas

# 1. quais saos os tres componentes de uma funcao no R ?
# R:
#   
# 2. O que a funcao f1(1)() retorna ?
# R:
# 
# 3. Como eu escreveria esse codigo tipicamente = " `+`(1, `*`(2, 3)) "
# R: 1 + (2 * 3) ou 1 + 2 * 3

# 4. How could you make this call easier to read ?
mean(, TRUE, x = c(1:10, NA))
# R:

# 5. Does the following function throw an error when called ? Why/why not ?
# 
# f2 <- function(a, b) {
#   a * 10
# }
# f2(10, stop("This is an error!"))
# 
# R: Funciona, porque...
#


# 6. What is an infix function? How do you write it? What's a replacement function? How do you write it ?
# R:
#


# 7. What function do you use to ensure that a cleanup action occurs regardless of how a function terminates ?
# R:

# Mais estudos sobre funcoes
# http://www.statmethods.net/management/userfunctions.html



#http://adv-r.had.co.nz/Functional-programming.html


#functional programming
#http://adv-r.had.co.nz/Functional-programming.html
