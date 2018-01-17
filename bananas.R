library(dplyr)
library(readr)
library(ggplot2)
theme_set(theme_bw())

## Can the magic numbers 1995… be easily avoided?
## Is this a good example of _not_ using fYear? Pipelining

(bananas <- read_csv(input_files[[1]])
	%>% select(-c(Domain, Element, Item))
	%>% mutate(Year=factor(Year))
)

print(ggplot(bananas, aes(x=Year, y=Value, color=Country))
	+ geom_line()
	+ aes(group=Country)
	# + scale_x_continuous(breaks=seq(1995, 2005, by=2))
)
