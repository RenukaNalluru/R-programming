#https://brilliant.org/discussions/thread/easy-way-to-find-cube-roots/?newwindow=true

numbers <- 0:10
#cubenum <- lapply(X = numbers, FUN = function(x) x ^ 3)
mod.cubenum <- lapply(X = numbers, FUN = function(x) c(x, x ^ 3, (x ^ 3)%%10) )

# tirando o cubo dos numeros 2;3;7 e 8, os numeros restantes, seu ultimo digito
# eh igual ao numero 'x' que foi elevado ao cubo, exemplo  9 ^ 3 = 729

# peguemos como exemplo o numero 226981
# peguemos os ultimos 3 digitos: 981
# o ultimo digito eh 1, assim a raiz cubica de 226981 tem como ultimo digito 1
# peguemos os 3 primeiros digitos 226
# 226 eh o mais proximo de 6 ^ 3 = 216
# entao raiz cubica de 226981 = 61

# 148877: o ultimo digito da raiz cubica eh 3, como pode ser visto na variavel mod.cubenum -> 7 ^ 3 = 343
# 148: o mais proximo eh 5 ^ 3 = 125
# raiz cubica 148877 : 53

# 42875
# 592704
# 1728

# 42875 : ultimo digito 5
# 42 -> 3 ^ 3
# 42875: 35

# 592704: 4
# 592 -> 8 ^ 3
# 592704: 84

# 1728 : 8 porem 8 ^ 3 : 512 entao ficamos com 2: 2 ^ 3 = 8, temos um 8
# 1: 1 ^ 3 = 1
# 1728 = 12











