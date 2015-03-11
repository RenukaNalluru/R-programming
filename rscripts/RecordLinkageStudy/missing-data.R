#http://www.statmethods.net/input/missingdata.html

is.na(c(1,2,3,T, NA))
# excluindo valores NA de uma analise, nesse caso a media aritmetica
mean(c(1,2,NA,3, 4:10), na.rm = T)
mean(c(1,2,NA,3))

# complete case
# https://stat.ethz.ch/R-manual/R-patched/library/stats/html/complete.cases.html
# retorna um vetor logico indicando quais casos sao completos, isto eh, nao tem valor faltando
# complete.cases(...)
# vetor com numeros aleatorios e NA inseridos em posicoes aleatorias no vetor
x <- sample(x = c(0:20, rep(NA, 10)))
# imprimindo onde nao contem NA
x[complete.cases(x)]

#  https://stat.ethz.ch/R-manual/R-patched/library/stats/html/na.fail.html
# a funcao na.omit retorna um objeto sem os elementos NA
x.omit <- na.omit(x)
# se na.omit remove linhas que contem valor NA, o atrbuto "na.action" da classe omit recebe o numero das linhas removidas

x.fail <- try(na.fail(object = x)) # retorna um objeto se nao tiver nenhum valor NA, do contrario retorna um error
x.pass <- na.pass(x.omit)

