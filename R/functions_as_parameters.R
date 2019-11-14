my_summary <- function(x, summary_fun = mean) {
	results <- summary_fun(x)
	return(results)
}

my_sampling <- function(n = 10, 
						sample_fun = rnorm, 
						...) {
	return(sample_fun(n, ...))
}

if(FALSE) {
	data(mtcars)
	x <- mtcars$mpg
	mean(x)
	my_summary(x)
	my_summary(x, summary_fun = median)
	
	my_sampling()
	my_sampling(sample_fun = rbinom,
				size = 0, prob = .1)
	
	my_sampling(sample_fun = rchisq,
				df = 30)
}