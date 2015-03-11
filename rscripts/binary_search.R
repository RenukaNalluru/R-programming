# http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/functions.pdf
# https://diegodonah.wordpress.com/2009/11/16/bug-secreto-na-busca-binaria/

binarySearch <- function(vect, search) {
    # http://stackoverflow.com/questions/9877271/how-to-check-existence-of-an-input-argument-for-r-functions
    # http://www.r-bloggers.com/programming-with-r-%E2%80%93-checking-function-arguments/
    if(missing(x = vect))
        stop("vector nao existe")
    if(missing(x = search))
        stop("search nao existe")
    
    len <- length(x = vect)
    l <- 0
    r <- len # vector no R vao de 1 a N
    
    while(l <= r) {
        m <- (l+r)/2
        l = m+1
    }
    -1
}

# http://stackoverflow.com/questions/13765972/how-to-randomize-a-vector
# http://stackoverflow.com/questions/17640617/in-r-how-do-i-locally-shuffle-a-vectors-elements

binarySearch(sample(x = (1:30)), 10)

