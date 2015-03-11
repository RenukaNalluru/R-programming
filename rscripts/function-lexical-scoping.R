# escopo lexico
# http://pt.wikipedia.org/wiki/L%C3%A9xico
# http://www.significados.com.br/lexico/
# a palavra lexico nao tem a ver com seu significado em portugues que eh um conjunto de palavras de um determinado idioma
# tem a ver com o significado dado pela ciencia da comp. "lexing".
# parte de um processo que converte codigo representado de forma textual em pedacos significativos
# que a linguagem de prog. entenda.

#http://stat.ethz.ch/R-manual/R-devel/library/base/html/formals.html
# testando escopo de variavel
x <- 10
z <- function(v) {
  x <- v
  x
}
z(100)
rm(z, x)


y <- function(a) {
  function() {
    a <- a + 2
    a
  }
}
y(10)()
rm(y)


test <- function() {
  y <- 0x0f
  # IIFE no R
  # https://gist.github.com/derrickturk/8836186
  (function() {
    # https://stat.ethz.ch/R-manual/R-devel/library/base/html/bitwise.html
    c <- bitwAnd(121, 1)
    c
  })()
}

test()
rm(test)

# name masking: principio 1
x <- 10
p <- function() {
  # se uma variavel nao estiver definida dentro da funcao o R pega a a mais proxima a cima
  # x <- 1
  y <- 2
  c(x, y)
  # c(p, y) 
}
p()
rm(p, x)

# a mesma regra de escopo de variavel vale para funcao definida dentro de funcao
# Procura-se uma funcao interna na propria funcao que supostamente a definiu
# se nao estiver sido definida na funcao interna que a chama, sera verificado logo acima no codigo
# depois nos pacoes intalados e depois mp ambiente global
x <- 1
i <- function() { print.default(x = "funcao i() externa" ) }

h <- function() {
  y <- 2
  #i <- function() {
  function() {
    z <- 3
    c(x, y, z)
  }
  i()
  #rm <- function(...) {
  function() {
    print.default(x = "funcao rm() externa" )
  }
  rm()
}
h()
rm(x, h, i)

# programacao funcional 
# http://adv-r.had.co.nz/Functional-programming.html#functional-programming

# o mesmo para as closures 
closure <- function(x) {
  y <- 2
  function() {
    c(x, y)
  }
}
# a recebe como retorno uma funcao, assim pode ser escrito a()
a <- closure(10)

# abaixo a recebe o retorno da closure, nao mais a funcao em si
# a <- closure(10)()

rm(closure, a)


# variaveis VS funcoes principio 2
# as regras que se aplicam as funcoes sao as mesmass para variaveis

i <- function(x) bitwShiftL(1000000, x)
j <- function() {
  #i <- function(x) bitwShiftL(a = 10000, n = x)
  # 10000:    10011100010000
  # 80000: 10011100010000000
  i(3)
}
j()
rm(i, j)
#rm(list = ls())

# Para as funcoes existe um pequeno ajuste a regra
# se vc esta usando um nome num contexto que eh obvio que vc quer chamar uma funcao, R ignorara objetos
# que nao sao funcao enquanto esta pesquisando
i <- function(x) bitwShiftL(2, x)
j <- function() {
  i <- 3
  # 10000:    10011100010000
  # 80000: 10011100010000000
  i(i)
}
j()
rm(i, j)

# a fresh start: principio 3

c(formals(z), body(z), environment(z))
# listar todos os objetos criados no ambiente R
ls(all.names = TRUE)