#https://stat.ethz.ch/R-manual/R-devel/library/utils/html/installed.packages.html
str(ip <- installed.packages(.Library, priority = "high"))
ip[, c(1,3:5)]

plic <- installed.packages(.Library, priority = "high", fields = "License")

## what licenses are there:
table( plic[, "License"] )

.Library

path <- gsub(pattern = "\\\\", replacement = "/", x = "C:\\Users\\christoffer\\Documents\\data\\lib-home")
installed.packages(path)
.libPaths()
installed.packages(.libPaths()[1])
installed.packages(.libPaths()[1])[, "Package"]