## getwd()
## setwd("C:/Users/georginaa/Documents/R/datasciencecoursera")


pollutantmean <- function(directory, pollutant, id = 1:332) {

  data_vector <- numeric()          ## creating empty numeric vector to hold all the datapoints
  
  
  files_list <- list.files(path = "C:/Users/georginaa/Documents/R/datasciencecoursera/specdata", all.files = FALSE,
             full.names = TRUE, include.dirs = TRUE)  ## creating a vector of all file paths so that they can be read
  
  for (i in id) {
    
    quick_df <- data.frame(read.csv(files_list[i], header = TRUE))   ## starting the for loop, to go through ID files, and read them
    quick_vector <- quick_df[[pollutant]]          ## grabs the whole column of the specified pollutant out of the quick dataframe
    data_vector <- c(data_vector, quick_vector)    ## this just appends the new vector to the end of the old vector in one long line
  
  }
  
    mean(data_vector, na.rm = TRUE)     ## current iterations mean that data_vector is FUCKED.

}


# source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript1.R")
# submit()

# str(quick_df)
# str(quick_vector)
# str(data_vector)
# help(rbind)

# pollutantmean("specdata", "sulfate", 1:1)
# pollutantmean("specdata", "sulfate", 2:3)

# pollutantmean("specdata", "sulfate", 1:10)  ## Should give 4.064 -- INCORRECT
# pollutantmean("specdata", "nitrate", 70:72) ## Should give 1.706 -- INCORRECT
# pollutantmean("specdata", "nitrate", 23)    ## Should give 1.281 -- CORRECT


