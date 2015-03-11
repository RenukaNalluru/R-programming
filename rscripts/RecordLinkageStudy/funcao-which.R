# uso da funcao which
# http://www.endmemo.com/program/R/which.php
# http://www.r-bloggers.com/a-multidimensional-which-function/

time <- c(1:5, 7)
demand <- c(8.3,10.3,19,16,15.6,19.8)
table <- as.data.frame(cbind(time, demand))

# funcao que analise conjunto de dados, como array, matrix, vectors e
# caos a condicao passada por parametro for verdadeira, ela retorna um vetor
# com os indices onde ocorreu correspondencia.
# parametros:
#x -> array ou vector com um condicional logico
#arr.ind -> se o elemento avaliado for do tipo array, deve-se retornar os indices ? T ou F

which(x = table$demand > 15, arr.ind = T)
which(x = table$demand > 15)

mat <- matrix(data = 1:9,nrow = 3, ncol = 3)
which(mat %% 3 == 0)
which(mat %% 3 == 0, arr.ind = T)

vect <- matrix(1:100, nrow = 1, ncol = 100)
which(vect %% 2 == 1, arr.ind = T)

dimnames(x = table)
dimnames(cbind(time, demand))

# http://stackoverflow.com/questions/7507765/which-function-for-matrix-indices
which(matrix(rep(c(0, 0, 1), 4), nrow = 4) == 1)
which(matrix(rep(c(0, 0, 1), 4), nrow = 4) == 1, arr.ind = T)


