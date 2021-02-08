library(tidyverse)
library(scales)


#RECREATING TOP-LINE CHART#####################

numbers <- c(483472, 438522, 383005, 320646, 287586, 299828, 297011, 281051, 291849, 303115, 374986, 347336, 305969, 257913, 238805, 238399, 226919, 227258, 235737, 242424, 123031, 124670, 124650, 122068, 119759, 120555, 121309, 121184, 121653, 122842)
year <- c("2008-09", "2009-10", "2010-11", "2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2016-17", "2017-18","2008-09", "2009-10", "2010-11", "2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2016-17", "2017-18", "2008-09", "2009-10", "2010-11", "2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2016-17", "2017-18")
class <- c("Enrolments", "Enrolments", "Enrolments", "Enrolments", "Enrolments", "Enrolments", "Enrolments", "Enrolments", "Enrolments", "Enrolments", "Students", "Students", "Students", "Students", "Students", "Students", "Students", "Students", "Students", "Students", "FTEs", "FTEs", "FTEs", "FTEs", "FTEs", "FTEs", "FTEs", "FTEs", "FTEs", "FTEs")

FTEs <- data.frame(numbers, year, class)

p <- ggplot(data=FTEs, aes(x=year, y=numbers, group=class, label = ',')) +
  geom_point(size = 4, aes(shape=class, color=class)) +
  geom_line(aes(linetype = class, color = class)) +
  scale_color_manual(values=c("#08519c","#3182bd", "#6baed6")) +
  labs(title="Figure 1: Number of Students, Enrolments and FTEs, 2008-09 to 2017-18", y="Total", x="") +
  scale_y_continuous(labels = scales::comma, limits = c(25000, 525000)) +
  theme_minimal()+
  theme(legend.title = element_blank()) +
  geom_text(aes(label = ifelse(year %in% "2017-18", comma(numbers), "")), hjust=.5, vjust= -.7) +
  geom_vline(xintercept = 2)

p + annotate("text",
             x = 4,
             y = 500000,
             label = "(Decline denotes policy shift away from funding \nshort courses/non-recognised qualifications)")


#######AGE CHART (dummy data)###############
numbers_age <- c(3918, 5671, 8583, 15323, 19504, 21276, 29345, 31008)
year_age <- c("2014-15", "2015-16", "2016-17", "2017-18","2014-15", "2015-16", "2016-17", "2017-18")
class_age <- c("Primary school", "Primary school", "Primary school", "Primary school", "High school", "High school", "High school", "High school")

AGE_graph <- data.frame(numbers_age, year_age, class_age)

ggplot(data = AGE_graph, aes(x=year_age, y=numbers_age, group = class_age, label = ',')) +
  geom_point (size = 4, aes(shape=class_age, color=class_age))+
  geom_line(aes(linetype = class_age, color = class_age)) +
  scale_color_manual(values=c("#8856a7", "#08519c")) +
  labs(title="Figure ?: Numbers of primary and high school students in colleges, 2014-15 to 2017-18", y="Total", x="") +
  scale_y_continuous(labels = scales::comma, limits = c(0, 35000))+
  theme_minimal() +
  theme(legend.title = element_blank()) +
  geom_text(aes(label = ifelse(year_age %in% c("2014-15", "2017-18"), comma(numbers_age), "")), hjust=.5, vjust= -.7)
