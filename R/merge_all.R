#' Merge multiple data.frames
#' 
#' @param ... the data.frames to merge
#' @param by
#' @param all
#' @param suffixes
#' @return merged data.frame
merge_all <- function(..., 
					  by, 
					  all = TRUE, 
					  suffixes = paste0('.', letters[1:length(list(...))])
) {
	dots <- list(...) # these will be the data.frames to merge
	
	# Do some minimal parameter checking
	if(!all(sapply(dots, is.data.frame))) {
		stop('All the unnamed parameters must be a data.frame.')
	}
	if(length(dots) == 1) { # Only one data.frame, return it
		warning('Only one data.frame provided.')
		return(dots[[1]])
	}
	if(length(suffixes) != length(dots)) {
		stop(paste0('Must specify suffixes (', length(dots), ' for all data.frames.'))
	}
	if(length(by) == 1) {
		by <- rep(by, length(dots))
	} else if(length(by) != length(dots)) {
		stop(paste0('The by parameter is not equal to ', length(dots)))
	}
	if(length(all) == 1) {
		all <- rep(all, length(dots))
	} else if(length(all) != length(dots)) {
		stop(paste0('The all parameter is not equal to ', length(dots)))
	}

	df <- dots[[1]]
	for(i in 2:length(dots)) {
		df <- merge(x = df, 
					y = dots[[i]],
					by.x = by[i-1],
					by.y = by[i],
					all.x = all[i-1],
					all.y = all[i])
	}
	return(df)
}

if(FALSE) { # To test the function
	library(tidyverse)
	
	data(tutoring, package = 'TriMatch')
	tutoring[1:10,]
	students <- tutoring[1:10, c('ID', 'Gender', 'Ethnicity')]
	coursework <- tutoring[1:8, c('ID', 'Course', 'Grade')]
	treatment <- tutoring[1:10, c('ID', 'treat')]

	merge_all(students, coursework, treatment, by = 'ID', all = TRUE)
	
	treatment <- treatment %>% rename(STUDENT_ID = ID)
	merge_all(students, coursework, treatment, all = TRUE)
	
	merge_all(students, coursework, treatment, by = c('ID', 'ID', 'STUDENT_ID'), all = TRUE)
}
