set.seed(612)
reps <- 2000
choices <- 5
guesses <- 7

print(mean(replicate(reps
	, length(unique(sample(1:choices, guesses, replace=TRUE)))==choices
)))
