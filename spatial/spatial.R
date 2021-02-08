library(leaflet)
library(rgdal)
library(tmaptools)

##################POPULATION FILES##############
#########APOLOGIES FOR THE SLOPPY WRANGLING#####
scot_pops <- read.csv("scot_pops.csv") %>% 
  gather(`total_pop`:`Age_90_and_over`, key="age", value = "total")

test <- filter(scot_pops, age == "total_pop")

scot_pops_real <- scot_pops %>% 
  filter(age %in% c("Age_16", "Age_17", "Age_18", "Age_19", "Age_20", "Age_21", "Age_22", "Age_23", "Age_24")) %>% 
  group_by(Council_areas) %>% 
  summarise(totals = sum(total)) 

scot_pops_real$scotland_total <- test$total[match(scot_pops_real$Council_areas, test$Council_areas)]

scot_pops_realest <- scot_pops_real %>% 
  mutate(percent = as.numeric(str_sub(totals / scotland_total * 100, 1,4)))
  
#####################################MAP OF OVERALL 16-24 POP STATS (NRS)################################
#shapefile
las <- readOGR("M:/Performance Measurement & Analysis/Josh/College_stats_pub/All-Scottish-Census-boundaries(shp)/CA_2011_EoR_Scotland.shp",
               layer = "CA_2011_EoR_Scotland", GDAL1_integer64_policy = TRUE)

#converting to WGS84
wgs_las <- spTransform(las, CRS("+proj=longlat +datum=WGS84"))

#simplifying
simplified_wgs_las <- rmapshaper::ms_simplify(wgs_las)

#Matching data to shapefile
simplified_wgs_las$NAME <- gsub("Na h-Eileanan an Iar", "Na h-Eileanan Siar", simplified_wgs_las$NAME)

simplified_wgs_las$OVERALL_PERCENT <- scot_pops_realest$percent[match(simplified_wgs_las$NAME, scot_pops_realest$Council_areas)]

#basic Viz
leaflet(simplified_wgs_las) %>%
  addPolygons(
    color = "#444444",
    weight = 1,
    smoothFactor = 0.5,
    opacity = 1.0,
    fillOpacity = 0.5,
    fillColor = ~ colorQuantile("YlOrRd", OVERALL_PERCENT)(OVERALL_PERCENT),
    highlightOptions = highlightOptions(
      color = "white",
      weight = 2,
      bringToFront = TRUE
    )
  )


#creating a legend
bins <- c(8,9,10,11,12,13,14)
pal <- colorBin("YlOrRd", domain = simplified_wgs_las$OVERALL_PERCENT, bins = bins)

#some HTML for the labels
labels <- sprintf(
  "<strong>%s</strong><br/>%g percent",
  simplified_wgs_las$NAME, simplified_wgs_las$OVERALL_PERCENT) %>% 
  lapply(htmltools::HTML)

#Viz with legend
leaflet(simplified_wgs_las) %>%
  addPolygons(fillColor = ~pal(OVERALL_PERCENT),
    color = "#444444",
    weight = 1,
    smoothFactor = 0.5,
    opacity = 1.0,
    fillOpacity = 0.5,
    highlightOptions = highlightOptions(
      color = "white",
      weight = 2,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>% 
  addLegend(pal=pal, values = ~OVERALL_PERCENT, opacity= 0.7, title = "Legend(%)", position = "bottomright") 
  
#####################################COLLEGE PROPORTIONS######################################
#Brought in from InFact

college_totes <- read.csv("college_totes.csv") %>% 
  mutate(percent = as.numeric(str_sub(X16_24 / overall * 100, 1, 4)),
         percentile = as.numeric(str_sub(X16_24 / overall, 1, 4)))

simplified_wgs_las$COLLEGE_PERCENT <- college_totes$percent[match(simplified_wgs_las$NAME, college_totes$LA_name)]
simplified_wgs_las$COLLEGE_PERCENTILE <- college_totes$percentile[match(simplified_wgs_las$NAME, college_totes$LA_name)]

simplified_wgs_las@data <- simplified_wgs_las@data %>% 
  mutate(PROPORTION = as.numeric(str_sub(OVERALL_PERCENT * COLLEGE_PERCENTILE,1,3)))
  
  
  #################################PROPORTION OF COLLEGE STUDENTS AGED 16-24

bins3 <- c(25,30,35,40,45,50,55)
pal3 <- colorBin("YlOrRd", domain = simplified_wgs_las$COLLEGE_PERCENT, bins = bins3)

labels3 <- sprintf(
  "<strong>%s</strong><br/>%g percent",
  simplified_wgs_las$NAME, simplified_wgs_las$COLLEGE_PERCENT) %>% 
  lapply(htmltools::HTML)

#Viz with legend
leaflet(simplified_wgs_las) %>%
  addPolygons(fillColor = ~pal3(COLLEGE_PERCENT),
              color = "#444444",
              weight = 1,
              smoothFactor = 0.5,
              opacity = 1.0,
              fillOpacity = 0.5,
              highlightOptions = highlightOptions(
                color = "white",
                weight = 2,
                bringToFront = TRUE),
              label = labels3,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>% 
  addLegend(pal=pal3, values = ~ COLLEGE_PERCENT, opacity= 0.7, title = "Legend(%)", position = "bottomright")



#######################################################PROPORTIONS OF PEOPLE AGED 16-24 IN COLLEGE
bins2 <- c(2,3,3.5,4,4.5,5,5.5,6,7)
pal2 <- colorBin("YlOrRd", domain = simplified_wgs_las$PROPORTION, bins = bins2)

labels2 <- sprintf(
  "<strong>%s</strong><br/>%g percent",
  simplified_wgs_las$NAME, simplified_wgs_las$PROPORTION) %>% 
  lapply(htmltools::HTML)

#Viz with legend
leaflet(simplified_wgs_las) %>%
  addPolygons(fillColor = ~pal2(PROPORTION),
              color = "#444444",
              weight = 1,
              smoothFactor = 0.5,
              opacity = 1.0,
              fillOpacity = 0.5,
              highlightOptions = highlightOptions(
                color = "white",
                weight = 2,
                bringToFront = TRUE),
              label = labels2,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>% 
  addLegend(pal=pal2, values = ~PROPORTION, opacity= 0.7, title = "Legend(%)", position = "bottomright") 

  
