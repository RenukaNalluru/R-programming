#http://www.jason-french.com/blog/2014/07/26/recursion-in-r/

jsp.rec <- function(n, k) {
  if(n ==1)
    1
  else
    # operador de modulo <- https://stat.ethz.ch/pipermail/r-help/2003-May/033921.html
    x <- (jsp.rec(n-1, k) + k-1) %% n + 1
}

c(jsp.rec(5, 2), jsp.rec(14, 2))
