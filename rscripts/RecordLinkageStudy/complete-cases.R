# como remover NA de um vetor, list ou data.frame

#http://stackoverflow.com/questions/4862178/remove-rows-with-nas-in-data-frame
x <- airquality[, -1]
y <- airquality[, 1]

stopifnot(... = complete.cases(y) != is.na(y))
ok <- complete.cases(x, y)
x[ok, ]
y[ok]

# ler tbm
#http://stackoverflow.com/questions/9126840/delete-rows-with-blank-values-in-one-particular-column
#http://stackoverflow.com/questions/7706876/r-script-removing-na-values-from-a-vector