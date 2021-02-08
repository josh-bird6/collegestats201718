library(waffle)
library(extrafont)
library(emojifont)

#LOADING FONTS
font_import()
load.fontawesome(font = "fontawesome-webfont.ttf")
###
#IF THAT DOES NOT WORK DOWNLOAD BRANDS, REGULAR AND SOLID TTF FROM HERE:
##https://github.com/FortAwesome/Font-Awesome/tree/master/webfonts
##
font_import(path = "C:/Users/jbird/Downloads", pattern = 'fa-', prompt = F)
####

#Load fonts in
loadfonts(device = "win")

#Check fonts are there
fonts()[grep("Awesome", fonts())]

#adding families to 'sysfonts'
library(showtext)
font_add(family = "FontAwesome5Free-Solid", regular = "C:\\Users\\jbird\\Downloads\\fa-solid-900.ttf")
font_add(family = "FontAwesome5Free-Regular", regular = "C:\\Users\\jbird\\Downloads\\fa-regular-400.ttf")
font_add(family = "FontAwesome5Brands-Regular", regular = "C:\\Users\\jbird\\Downloads\\fa-brands-400.ttf")
showtext_auto()

parts <-
  c(
    `FE\nPart Time\n(208,189)` = 68,
    `FE\nFull Time\n(45,340)` = 15,
    `HE\nFull Time\n(32,529)` = 11,
    `HE\nPart Time\n(17,057)` = 6
  )

#now you can load glyphs
waffle(
  parts,
  rows = 5,
  size = 3,
  colors = c("#c51b8a", "#fa9fb5", "#c6dbef", "#08306b"),
  title = "College students by level and study mode, 2017-18",
  legend_pos = "bottom",
  xlab = "each person represents ~3,000 enrolments",
  use_glyph = "apple"
)
##########################################################################
parts2 <-
  c(
    `First Degree` = 56,
    `Taught PG` = 16,
    `HNC/HND` = 14,
    `Other sub-degree` = 9,
    `Research PG` = 5
  )

waffle(
  parts2,
  rows = 5,
  size = 3,
  colors = c("#08306b", "#08519c", "#4292c6", "#9ecae1", "#deebf7"),
  title = "Figure 1: Proportional split of students in higher education in Scottish HEIs and colleges by level of Study,\n 2017-18 ",
  legend_pos = "right",
  use_glyph = "child"
)

###########################################################################
