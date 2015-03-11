# teste com as funcoes da familia apply # usar a logica c(3,4,5,6,7)
# nao funciona como esperado
# lapply(c(6,7), function(i) unix.time(sim.fonetic[, i] <- as.factor(sim.fonetic[, i])))
# apply(array(6:7, dim = 1:2), MARGIN = 1, function(i) unix.time(sim.fonetic[, i] <- as.factor(sim.fonetic[, i])))


# passo a passo, nao eh mais util

unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 2))
# usuario   sistema decorrido 
# 3.09      0.21      3.29
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 7, sobraram 9931439
unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 3))
# usuario   sistema decorrido 
# 2.97      0.26      3.27 
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 0, sobraram 9931439
unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 4))
# usuario   sistema decorrido 
# 3.14      0.10      3.25
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 1, sobraram 9931438
unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 5))
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 269917, sobraram 9661521
unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 6))
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 23536, sobraram 9637985
unix.time(sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = 7))
# nrow(sim.fonetic.notna) # nrow(sim.fonetic) - nrow(sim.fonetic.notna) retirados 0, sobraram 9637985

########################## fim passo a passo, #############################


clear <- function() {
#s <- c(c(), nrow(sim.fonetic) - nrow(sim.fonetic.notna))
for(i in 2:ncol(sim.fonetic.notna) ) { 
    #v <- nrow(sim.fonetic.notna)
    sim.fonetic.notna <- listNotNa(X = sim.fonetic.notna, fields = i)
    #s <- c(s, v - nrow(sim.fonetic.notna))
    #s <- c(s, nrow(sim.fonetic.notna))
}
sim.fonetic.notna
    
# unix.time(expr = clear())
# # usuario   sistema decorrido 
# # 28.32      1.34     29.83 
# sapply(1:ncol(sim.fonetic.notna), function(i) nrow(sim.fonetic.notna[is.na(sim.fonetic.notna[, i]), ]))
    