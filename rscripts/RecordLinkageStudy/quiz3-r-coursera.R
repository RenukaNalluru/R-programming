data(iris)
?iris

#question 1
mean(iris[iris$Species == "virginica", ]$Sepal.Length)

#quastion 2
apply(iris[, 1:4], 2, mean)

#para a questao 3
data(mtcars)
?mtcars
#question 3
# How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
with(mtcars, tapply(mpg, cyl, mean))
mtcars[1:8, ]
tapply(mtcars$mpg, mtcars$cyl, mean)

# question 4
# what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars
ca <- mtcars[mtcars$cyl == 4, ]
cb <- mtcars[mtcars$cyl == 8, ]
mean(ca$hp)
mean(cb$hp)
abs(mean(ca$hp) -  mean(cb$hp))
#debug(ls())
