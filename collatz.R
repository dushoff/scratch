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
		v[i] <<- n
	}
	length(n) <- i
	return(n)
}

# series(27)

x <- seq(from=11, to=211, by=2)
y <- collStep(x)

plot(x, y
	, type="p"
	# , log="xy"
)
print(data.frame(x, y))
