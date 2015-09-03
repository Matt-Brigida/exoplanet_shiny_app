## Get and display exoplanet data ----
## app pulls data twice, fix to only require one ----

library(DT)
library(threejs)

ui <- bootstrapPage(
        tabsetPanel(type = "tabs",
                    tabPanel("Data", DT::dataTableOutput("datatable")),
                    tabPanel("Plot", threejs::scatterplotThreeOutput("plot"))
                    )
    )
    
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

output$plot <- threejs::renderScatterplotThree({

url <- "https://raw.githubusercontent.com/OpenExoplanetCatalogue/oec_tables/master/comma_separated/open_exoplanet_catalogue.txt"
library(RCurl)
## x <- getURL(url)
## get data
data <- read.csv(url, skip = 30, stringsAsFactors = F)
## column names
names(data) <- c("Primary ID", "Binary Flag", "Planetary Mass", "Radius", "Period", "Axis", "Eccentricity", "Periastron", "Longitude" ,"Ascending Node", "Inclination", "Temp", "Age", "Discovery Method" ,"Discovery Year", "Last Updated", "Right Ascension", "Declination", "Distance from Sun (parsec)", "Host Start Mass", "Host Star Radius", "HS Metallicity", "HS temp" ,"HS age")


data.three <- data[,c(3,15,19)]
data.three[,1] <- log(data.three[,1])
data.three[,3] <- log(data.three[,3])
data.three2 <- data.three[complete.cases(data.three),]

## order by year
data.three2 <- data.three2[ order(-data.three2[,2]),]

    scatterplot3js(x = data.three2, labels = data$'Primary ID', color = rainbow(length(data.three2[,2])), label.margin = TRUE, flip.y = TRUE)

})


}

shinyApp(ui = ui, server = server)
