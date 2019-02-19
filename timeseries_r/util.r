install_packages <- function(x, quietly=FALSE, warn.conflicts=TRUE){
  for( i in x ){
    if( ! require( i , character.only = TRUE, quietly = quietly, warn.conflicts = warn.conflicts ) ){
      install.packages( i , dependencies = TRUE )
      require( i , character.only = TRUE, quietly = quietly, warn.conflicts = warn.conflicts )
    }
  }
}

get_bond_yields_uk_10y_data_ts <- function(required_dataset) 
{
    data = get_bond_yields_uk_10y_data(required_dataset)
    return(ts(data$Rate, start = c(1984, 03), frequency = 4))
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

get_stedmondsbury_new_homes_ts <- function() 
{
    # https://data.gov.uk/dataset/6eb509cd-be2b-4ef5-882c-84d9146e5522/house-sales-and-prices
    url = 'https://data.cambridgeshireinsight.org.uk/sites/default/files/ons-new-build-count-corrected_0.csv'

    raw <- read.csv(url(url))
    stedmundsbury = raw[ raw$Area == 'St Edmundsbury', 3:ncol(raw) ]
    return(ts(t(stedmundsbury), start=c(1995, 4), frequency=4))
}

get_ibm_daily_close_change_ts <- function()
{
    options("getSymbols.warning4.0"=FALSE)  
    options("getSymbols.yahoo.warning"=FALSE)
    getSymbols("IBM",src="yahoo")
    daily_change = diff(Cl(IBM))
    return(daily_change)
}