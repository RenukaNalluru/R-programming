#http://www.pitt.edu/~njc23/Lecture4.pdf
# data.frame incluso no R por padrao
class(ToothGrowth)                  # ToothGrowth eh u objeto, data.frame eh a classe desse objeto
summary(ToothGrowth)                # summary() eh um metodo generico que chama o metodo summary.data.frame()
summary.data.frame(ToothGrowth)

# lm() retorna um objeto de modelo linear, se passarmos o um objeto de lm para summary()
# a funcao chamara a summary.lm()

# operador til(tilde)
#https://stat.ethz.ch/R-manual/R-devel/library/base/html/tilde.html

ans <- lm(formula = len ~ dose + factor(supp), data = ToothGrowth)
class(ans)
summary(ans)
summary.lm(ans)

