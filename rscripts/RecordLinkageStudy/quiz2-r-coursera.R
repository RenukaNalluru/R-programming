# question 2
x <- 1:10
if(x > 5) {
    x <- 0
}

#question 3
f <- function(x) {
    g <- function(y) {
        print("g")
        y + z
    }
    print("f")
    z <- 4
    x + g(x)
}

# question 4
x <- 5
y <- if(x < 3) {
    NA
} else {
    10
}

# question 5
h <- function(x, y = NULL, d = 3L) {
    # variaveis numa funcao
    z <- cbind(x, d)    # x e d sao local variables z eh formal parameter
    if(!is.null(y)) {
        z <- z + y
    } else {
        z <- z + f      # eh uma free variable, se 'f' receber algum valor dentro da funcao, o escopo dela se torna local
    }
    #return(z)
    g <- x + y / z
    if(d == 3L)
        return(g)
    g <- g + 10
    g
}

#test 5
z <- cbind(1:30, 3L)
z <- z + 1
g <- (1:30) + 1 / z
#fim test 5

#question 6
# links para ajudar a responder - ler
# http://faculty.washington.edu/gyollin/docs/rEnvironment.pdf
# https://github.com/jtleek/modules/blob/master/02_RProgramming/Scoping/index.md
# http://cran.r-project.org/doc/contrib/Fox-Companion/appendix-scope.pdf
# http://adv-r.had.co.nz/Environments.html
# http://adv-r.had.co.nz/Functions.html#lexical-scoping

# http://stackoverflow.com/questions/20766649/understanding-lexical-scoping-in-r
# http://wiki.math.yorku.ca/index.php/R:_Scoping_of_free_variable_names

# sobre parent env
# http://www.inside-r.org/r-doc/base/sys.call

# Question 10
# In R, what is the parent frame?
# R: It is the environment in which a function was called

# parent.env(env = environment())

#fim question 6
