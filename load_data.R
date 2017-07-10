url<-"http://opendata-ajuntament.barcelona.cat/data/dataset/e769eb9d-d778-4cd7-9e3a-5858bba49b20/resource/be253540-d3ec-418f-9b72-386492fa5269/download/2016_accidents_gu_bcn_.csv"

dfnames<-c(
"record.number ",
"distrinct.code",
"district.name",
"quarter.code",
"quarter.name",
"street.code",
"street.name",
"street.number",
"week.day.name",
"week.day",
"day.type",
"year",
"month",
"month.name",
"month.day",
"hour",
"shift",
"cause.description.pedestrian",
"fatalities",
"minor.injuries",
"serious.injuries",
"vehicles.involved",
"utm.x",
"utm.y",
"long",
"lat")

df <- read.csv(url,col.names = dfnames)

#create map

df<-df[df$long<100,]
df<-df[df$lat<100,]

#df<-df[df$fatalities>0,]
#df<-df[df$fatalities>0 | df$serious.injuries>0,]
str(df)

markers <- data.frame (longitude=df$long, latitude=df$lat)

summary(markers)

library(leaflet)

popupdata <- paste("<b>date: ", df$month.day,"/",df$month,"/",df$year,"</b>",
                   "<br/> deaths: ",df$fatalities,
                   "<br/> serious injuries: ",df$serious.injuries,
                   "<br/> minor injuries: ",df$minor.injuries
                   )

leaflet(data = markers ) %>%  addTiles()  %>% 
    addMarkers(popup = popupdata, clusterOptions=markerClusterOptions()) 
