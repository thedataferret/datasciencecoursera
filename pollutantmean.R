# getwd()
# setwd("C:/Users/Perky Llama/Documents/R/datasciencecoursera")


pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  data_vector <- numeric()          ## creating empty numeric vector to hold all the datapoints
  
  files_list <- list.files(path = "C:/Users/Perky Llama/Documents/R/datasciencecoursera/specdata", all.files = FALSE,
                           full.names = TRUE, include.dirs = TRUE)  ## creating a vector of all file paths so that they can be read
  
  for (i in id) {
    
    quick_df <- data.frame(read.csv(files_list[i], header = TRUE))   ## starting the for loop, to go through ID files, and read them
    quick_vector <- quick_df[,pollutant]
    data_vector <- c(data_vector, quick_vector)
    
  }
  
  mean(data_vector, na.rm = TRUE)
  
}

# pollutantmean("specdata", "sulfate", 1:10)  ## Should give 4.064
# pollutantmean("specdata", "nitrate", 70:72) ## Should give 1.706 
# pollutantmean("specdata", "nitrate", 23)    ## Should give 1.281 
