# http://adv-r.had.co.nz/Performance.html


install.packages(pkgs = "microbenchmark")
library(microbenchmark)

x <- runif(100)

microbenchmark(sqrt(x), x ^ 0.5)
