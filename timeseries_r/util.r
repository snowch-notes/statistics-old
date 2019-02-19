install_packages <- function(x, quietly=FALSE, warn.conflicts=TRUE){
  for( i in x ){
    if( ! require( i , character.only = TRUE, quietly = quietly, warn.conflicts = warn.conflicts ) ){
      install.packages( i , dependencies = TRUE )
      require( i , character.only = TRUE, quietly = quietly, warn.conflicts = warn.conflicts )
    }
  }
}

get_bond_yields_uk_10y_data <- function(required_dataset) 
{
    stopifnot(required_dataset %in% c('quarterly_csv.csv', 'abc'))
    
    if(!require(jsonlite, quietly = TRUE)){
        install.packages("jsonlite", repos="https://cran.rstudio.com/")
        require(jsonlite, quietly = TRUE)
    }
    
    # hide warning about json file
    oldw <- getOption("warn")
    options(warn = -1)
    
    json_file <- 'https://datahub.io/core/bond-yields-uk-10y/datapackage.json'
    json_data <- fromJSON(paste(readLines(json_file), collapse=""))

    for(i in 1:length(json_data$resources$datahub$type)){
      if(json_data$resources$datahub$type[i]=='derived/csv' ){

        path_to_file = json_data$resources$path[i]
        file_name = tail(unlist(strsplit(path_to_file, '/')), 1)

        if(file_name == required_dataset){
            data <- read.csv(url(path_to_file))
        }
      }
    }
    options(warn = oldw)
    return(data)
}