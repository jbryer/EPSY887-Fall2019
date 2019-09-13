library(ggplot2)

data(tutoring, package='TriMatch')
str(tutoring)

ggplot(tutoring, aes(x = Age)) + geom_histogram()
ggplot(tutoring, aes(x = Age)) + geom_histogram(bins = 10)
ggplot(tutoring, aes(x = Age)) + geom_histogram(binwidth = 1)

ggplot(tutoring, aes(x = Age, fill=treat)) + geom_histogram()

# Density
ggplot(tutoring, aes(x = Age)) + geom_density()

ggplot(tutoring, aes(x = Age, fill=treat)) + geom_density()
ggplot(tutoring, aes(x = Age, color=treat)) + geom_density()
ggplot(tutoring, aes(x = Age, linetype=treat)) + geom_density()

ggplot(tutoring, aes(x = Age, color=treat, linetype=treat)) + 
	geom_density() +
	facet_wrap(~ treat, ncol = 2)

ggplot(tutoring, aes(x = treat)) + geom_bar()

treat_sum <- as.data.frame(table(tutoring$treat))

ggplot(treat_sum, aes(x = Var1, y = Freq, label = Freq)) +
	geom_bar(stat='identity', alpha = .75, fill='purple4') +
	geom_text(vjust=-0.5) +
	ylim(c(0, 1000)) +
	xlab('') +
	ylab('Frequency')

ggplot(tutoring, aes(x = 'Something', y = GPA)) + geom_boxplot()

ggplot(tutoring, aes(x = Age, y = GPA, color = Gender)) + 
	geom_point() +
	scale_color_brewer(type='qual', palette = )

ggplot(tutoring, aes(x = Age, y = GPA, color = Gender)) + 
	geom_point() +
	scale_color_manual(values = c('FEMALE' = 'orange', 'MALE' = 'purple3'))

tab <- psych::describeBy(tutoring$Grade, tutoring$treat, mat = TRUE, skew = FALSE)

ggplot(tab, aes(x = group1, y = mean)) + 
	geom_errorbar(aes(ymin = mean - (1.96*se), ymax = mean + (1.96* se))) +
	geom_point(size = 3, color = 'blue') + 
	geom_text(aes(label = round(mean, digits = 2), hjust = -0.25))

df <- rbind(data.frame(x1 = -1, 
				 x2 = .5, 
				 y1 = -1, 
				 y2 = .5),
			data.frame(x1 = 0.5, 
					   x2 = 4, 
					   y1 = 2, 
					   y2 = 4),
			data.frame(x1 = 0.5, 
					   x2 = 1, 
					   y1 = 2, 
					   y2 = 2)
			
)

ggplot() +
	geom_segment(data=df, aes(x=x1, y=y1, xend=x2, yend=y2)) +
	xlim(c(-1, 5)) + ylim(c(-1,5))
