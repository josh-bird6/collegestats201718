library(waffle)
library(extrafont)
library(emojifont)

#LOADING FONTS
###NOTE THIS STEP TAKES FOREVER - EXECUTE AND THEN GO GET A CUPPA
font_import()                                            
load.fontawesome(font = "fontawesome-webfont.ttf")
fonts()[grep("Awesome", fonts())]
loadfonts(device = "win")


parts <-
  c(
    `FE\nPart Time\n(208,189)` = 68,
    `FE\nFull Time\n(45,340)` = 15,
    `HE\nFull Time\n(32,529)` = 11,
    `HE\nPart Time\n(17,057)` = 6
  )

waffle(
  parts,
  rows = 5,
  size = 3,
  colors = c("#c51b8a", "#fa9fb5", "#c6dbef", "#08306b"),
  title = "College students by level and study mode, 2017-18",
  legend_pos = "bottom",
  xlab = "each person represents ~3,000 enrolments",
  use_glyph = "child"
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

