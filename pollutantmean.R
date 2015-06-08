
setwd("C:/Users/georginaa/Documents/R/datasciencecoursera")


pollutantmean <- function(directory, pollutant, id = 1:332) {

  means_vector <- numeric(length = length(id))          ## creating empty numeric vector to hold all the means
  slot <- 1                                             ## starting slot, always 1 (in case ID doesn't start at 1)
  files_list <- list.files(path = "C:/Users/georginaa/Documents/R/datasciencecoursera/specdata", all.files = FALSE,
             full.names = TRUE, include.dirs = TRUE)  ## creating a vector of all file paths so that they can be read
  
  for (i in id) {
    
    quick_df <- data.frame(read.csv(files_list[i], header = TRUE))   ## starting the for loop, to go through ID files, and read them
    
    means_vector[slot] <- mean(quick_df[,pollutant], na.rm=TRUE)    ## grab the mean of the entire <pollutant> column in this quick_df, post to means_vector
    slot <- slot + 1                                                ## slot now ticks up by one
  }
  
    mean(means_vector)
                 
}




pollutantmean("specdata", "sulfate", 1:1)
pollutantmean("specdata", "sulfate", 2:3)

pollutantmean("specdata", "sulfate", 1:10)  ## Should give 4.064 -- INCORRECT
pollutantmean("specdata", "nitrate", 70:72) ## Should give 1.706 -- INCORRECT
pollutantmean("specdata", "nitrate", 23)    ## Should give 1.281 -- CORRECT
