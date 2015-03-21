# metodos uteis no teste com a biblioteca de RecordLinkage


# esse metodo lista os elementos encontrados num data.frame que tem campo com valor NA
# esses campos sao indicados atraves de um vetor passado como argumento num metodo
listNa <- function(X = NULL, fields = NULL) {
    if(is.null(X) || is.null(fields)) {
        fields <- 1:length(colnames(X))
        X[is.na(X[, fields]), ]
    } else {
        X[is.na(X[, fields]), ]
    }
}

listNotNa <- function(X = NULL, fields = NULL) {
    if(is.null(X) || is.null(fields)) {
        fields <- 1:length(colnames(X))
        X[is.na(X[, fields]), ]
    } else {
        X[!is.na(X[, fields]), ]
    } 
}

# lista os elementos de um data.frame a partir de campos especificos
# que sao deifinidos atraves de um vetor e esses campos sao avaliados por
# um vetor de criterios
listFieldsByCriteria <- function(X = NULL, fields = NULL, criteria = c(1)) {
    #print(X)
    X[X[, fields] == criteria, ]
}

listByFields <- function(X = NULL, fields = NULL) {
    if(is.null(fields)) {
        fields = colnames(X)
    }
    X[, fields]
}


# calcular a media dos campos de um data frame, passando quais campos
# serao usados para calcular a media
# a funcao retorna uma matrix, que o usuario pode definir quais campos
# formaram a nova matriz

apply.mean <- function(table = NULL, fields.mean = NULL, fields.bind = NULL) {
#     matrix <- sapply(X = table, function(e){
#         e  
#     })
    matrix <- as.matrix(table)
    matrix.final <- cbind(matrix[, fields.bind],  mean = apply(X = matrix[, fields.mean], MARGIN = 1, mean))
    matrix.final
}

clear.all.matrix <- function(data, fields = NULL) {
    if(is.null(fields)) {
        fields = 1:ncol(data)
    }
    unix.time(for(i in fields) {
        print(nrow(data))
        data <- listNotNa(X = data, fields = i)
    })
    data
}

data.contains <- function(data1, data2) {
    
}

# criar um subconjunto atraves de um criterio sobre os campos da estrutura de dados
subsetByCriteria <- function(X = NULL, criteria = NULL ) {
    
}