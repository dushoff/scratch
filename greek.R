library(ggplot2)
α <- 1:10
β <- α^2

dat <- data.frame(α, β)
print(dat)

print(ggplot(dat, aes(x=α, y=β))
	+ geom_line()
)
