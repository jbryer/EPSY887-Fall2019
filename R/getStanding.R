getStanding <- function(credits, 
						breaks=c(30, 60, 90),
						labels=c('Freshman','Sophomore', 'Junior', 'Senior')) {
	results <- cut(credits, breaks=c(0, breaks, Inf), labels=labels, 
				   include.lowest=TRUE, right=FALSE)
	return(results)
}

if(FALSE) {
	getStanding(42)
	getStanding(-1)
}
