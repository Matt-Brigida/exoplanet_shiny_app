## Get and display exoplanet data ----

library(DT)

ui <- bootstrapPage(
  DT::dataTableOutput("datatable"))

server <- function(input, output){

output$datatable <- DT::renderDataTable({ 

    ## data location ----
url <- "https://raw.githubusercontent.com/OpenExoplanetCatalogue/oec_tables/master/comma_separated/open_exoplanet_catalogue.txt"
library(RCurl)
## x <- getURL(url)
## get data
data <- read.csv(url, skip = 30, stringsAsFactors = F)
## column names
names(data) <- c("Primary ID", "Binary Flag", "Planetary Mass", "Radius", "Period", "Axis", "Eccentricity", "Periastron", "Longitude" ,"Ascending Node", "Inclination", "Temp", "Age", "Discovery Method" ,"Discovery Year", "Last Updated", "Right Ascension", "Declination", "Distance from Sun (parsec)", "Host Start Mass", "Host Star Radius", "HS Metallicity", "HS temp" ,"HS age")

    ## display data with datatable from DT package ----
    
DT::datatable(data[, c("Primary ID", "Binary Flag", "Planetary Mass", "Discovery Year", "Distance from Sun (parsec)")], options = list(pageLength = 15))

})
}

shinyApp(ui = ui, server = server)
