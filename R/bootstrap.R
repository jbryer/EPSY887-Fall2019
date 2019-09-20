#' Generate bootstrap samples
#' 
#' This function creates a bootstrap distribution. The `print`, `summary`,
#' and `plot` functions can be used to get relevant information about the
#' bootstrap sample.
#' 
#' @param x sample from which to take bootstrap samples from
#' @param n.boot.samples number of bootstrap samples to take
#' @param ... other parameters (currently unused)
bootstrap <- function(x, 
					  n.boot.samples = 1000,
					  ...) {
	bootstrap <- list()
	bootstrap$samples <- list()
	for(i in seq_len(n.boot.samples)) { 
		bootstrap$samples[[i]] <- sample(x, size = length(x), replace = TRUE)
	}
	bootstrap$sample <- x
	class(bootstrap) <- 'bootstrap'
	return(bootstrap)
}

#' Print function for boostrap
#' 
#' @param x the result of the bootstrap call
#' @param ci whether to include the confidence interval. Value should be between
#'        0 and 1 for the desired CI (e.g. .95 for a 95% confidence interval).
#' @param ... currently unused
print.bootstrap <- function(x, metric = mean, ci, ...) {
	boot_dist <- sapply(x$samples, metric, ...)
	value <- metric(boot_dist)
	value.sd <- sd(boot_dist)
	ci.str <- ''
	if(!missing(ci)) {
		cv <- abs(qnorm((1 - ci) / 2))
		ci.str <- paste0(' (', round(ci * 100), '% confidence interval: ',
						 round(value - cv * value.sd, digits = 2), ', ', 
						 round(value + cv * value.sd, digits = 2), ')')
	}
	print(paste0('Bootstrap value of ', round(value, digits = 2), ci.str,
			 ' was obtained from a bootstrap distribution (n = ', length(x$samples), 
			 ') of an original sample of ', length(x$sample), ' observations.'))
}

#' Prints the summary of the boostrap distribution
#' 
#' @param x the result of the boostrap call
#' @param metric the desired summary statistic (default is mean)
summary.bootstrap <- function(x, metric = mean, ...) {
	boot_dist <- sapply(x$samples, metric, ...)
	return(mean(boot_dist))
}

#' Plots the boostrap distribution
#' 
#' @param x the result of the bootstrap call
#' @param metric the desired summary statistic (default is mean)
plot.bootstrap <- function(x, metric = mean, ...) {
	boot_dist <- sapply(x$samples, metric, ...)
	d <- density(boot_dist)
	h <- hist(boot_dist, plot=FALSE)
	hist(boot_dist, main='Bootstrap Distribution', xlab="", freq=FALSE, 
		 ylim=c(0, max(d$y, h$density)+.5), col='#569BBDC0', border = "white", 
		 cex.main = 1.5, cex.axis = 1.5, cex.lab = 1.5)
	lines(d, lwd=3)
}

if(FALSE) { # Test the functions
	n <- 1e5
	pop <- runif(n, 0, 1)
	samp1 <- sample(pop, size = 50)
	
	boot1 <- bootstrap(samp1)
	class(boot1)
	print(boot1)
	print(boot1, ci = 0.95)
	summary(boot1)
	summary(boot1, median)
	summary(boot1, sd)
	plot(boot1)
	plot(boot1, metric = median)
	
	plot(bootstrap(	
		sample(pop, size = 400)),
		 metric = median)
}

