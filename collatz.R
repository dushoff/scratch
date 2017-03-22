uneven <- function(n, b=1){
	while(n%%2==0){
		n <- b*(n/2)
	}
	return(n)
}

collStepCalc <- function(n){
	return(uneven(uneven(n+1, 3)-1))
}
collStep <- Vectorize(collStepCalc)

series <- function(n, max=1000){
	v <- numeric(max)
	v[1] <- n
	i <- 1
	while(n!=1 & i<max){
		i <- i+1
		n <- collStep(n)
		v[i] <- n
	}
	return(v[1:i])
}

x <- seq(from=11, to=2017, by=2)
# series(2413)

x <- seq(from=11, to=2011, by=2)
y <- collStep(x)

plot(x, y
	, type="p"
	, log="xy"
)
lines(x, x)
<<<<<<< HEAD

# print(data.frame(x, y))
=======
print(data.frame(x, y))
>>>>>>> 4469dc2f56f3c4975bcb24ebdf3de9e2f8930cf4
