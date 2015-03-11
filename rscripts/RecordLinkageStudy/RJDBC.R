#http://docs.oracle.com/cd/B19306_01/server.102/b14357/ch3.htm#i1142498
#https://blogs.oracle.com/R/entry/r_to_oracle_database_connectivity
library(RJDBC)

drive <- JDBC(driverClass = "oracle.jdbc.OracleDriver", classPath = paste(getwd(), "/ojdbc6.jar", sep = ""), identifier.quote = " ")
con <- dbConnect(drv = drive, "jdbc:oracle:thin:@localhost:1521/xe", "SYSTEM", "admin")
#dbGetQuery(con, "select count(*) from TEST_PAUA")
query <- dbGetQuery(con, "select SK, SEXO, EDNERECO, OBITO  from TEST_PAUA")

query[!is.na(query$EDNERECO), ]
endereco <- query[!is.na(query$EDNERECO), ]$EDNERECO

# lapply(endereco, FUN = function(str) {
#     ?gregexpr
# })

wrapper.regex <- function(pattern, replacement, x, ignore.case = T, perl = FALSE, fixed = FALSE, useBytes = FALSE, strFun) {
    
    if(missing(replacement)) {
        lapply(x, FUN = function(str) {
            #?gregexpr
            #gregexpr(pattern = pattern, text = str, ignore.case = T)
        }) 
    }
    else {
        lapply(X = x,FUN = function(str){
            sub(pattern = pattern, replacement = replacement, x = str, ignore.case = T)
        })
    }
}

#http://www.autohotkey.com/docs/misc/RegEx-QuickRef.htm

# comeca com av.(ponto) e tem 0 ou mais espacos a frente
#a1 <- wrapper.regex(pattern = "^av\\.\\s{0,}|^AVENIDA\\s{0, }",replacement = "",  x = endereco)
#a2 <- wrapper.regex(pattern = "(^av\\.|^AVENIDA)\\s{0, }",replacement = "",  x = endereco)
a2 <- wrapper.regex(pattern = "^(av\\.|AVENIDA)\\s{0, }",replacement = "AVENIDA ",  x = endereco)

#http://stackoverflow.com/questions/17598134/compare-two-lists-in-r
#a1 %in% a2
#cbind(a1, a2, endereco)

# comeca com r. ou rua: ou R: (...) as 3 expressoes resolvem, mas a terceira eh mais simples ...
#r1 <- wrapper.regex(pattern = "^r\\.\\s{0,}|^RUA\\:|^R\\:\\s{1,}|^RUA\\s{1, }|^RUA(\\:|\\.)\\s{0, }",replacement = "",  x = endereco)
#r2 <- wrapper.regex(pattern = "(^r\\.|^RUA(\\:|\\.)|^R\\:|^RUA)\\s{0, }", replacement = "",  x = a2)
r2 <- wrapper.regex(pattern = "^(r\\.|RUA(\\:|\\.)|R\\:|RUA)\\s{0, }", replacement = "RUA ",  x = a2)
#r1 %in% r2
#cbind(r1, r2, endereco)
cbind(r2, endereco)

# string comeca com FAZ
f1 <- wrapper.regex(pattern = "^(FAZ)\\s{1, }", replacement = "FAZENDA ", x = r2)
cbind(f1, endereco)

# string comeca com EST. e possui ao menos um espaco,  trocar por ESTRADA
e1 <- wrapper.regex(pattern = "^(EST(\\.|\\s{1, }))\\s{1, }", replacement = "ESTRADA ", x = f1)
cbind(e1, endereco)

# string comeca com POV ... trocar por POVOADO
p1 <- wrapper.regex(pattern = "^(POV)\\s{1, }", replacement = "POVOADO ", x = e1)
cbind(p1, endereco)

# string comeca com LOT ... trocar por LOTE
l1 <- wrapper.regex(pattern = "^(LOT)\\s{1, }", replacement = "LOTE ", x = p1)
cbind(l1, endereco)[17,]
