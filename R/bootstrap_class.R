bootstrap <- function(x, n.boot.samples = 1000, ...) {
	boot <- list()
	boot$samples <- list()
	boot.samples <- numeric(n.boot.samples)
	for(i in seq_along(boot.samples)) { 
		boot$samples[[i]] <- sample(x, size = length(x), replace = TRUE)
	}
	boot$sample <- x
	class(boot) <- 'bootstrap'
	return(boot)
}

print.bootstrap <- function(x, metric = mean, ci, ...) {
	boot_dist <- sapply(x$samples, metric, ...)
	value <- mean(boot_dist)
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
summary.bootstrap <- function(x, metric = mean, ...) {
	tmp <- sapply(x$samples, metric)
	return(mean(tmp))
}

plot.bootstrap <- function(x, ...) {
	print('Inside plot.bootstrap')
}

if(FALSE) {
	n <- 1e5
	pop <- runif(n, 0, 1)
	samp <- sample(pop, size = 50)
	head(samp)
	length(samp)
	
	test <- bootstrap(samp, n.boot.samples = 500)
	ls(test)
	
	class(test)
	print(test)
	print(test, ci = .95)
	
	summary(test)
	summary(test, metric = median)
	summary(test, metric = sd)
	plot(test)
	
	tmp <- sapply(test$samples, mean)
	head(tmp)
}
