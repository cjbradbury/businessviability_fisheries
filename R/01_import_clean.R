
#Set up ----

#Install relevant packages
install.packages ("rmarkdown") #creating rmarkdown file
install.packages ("tidyverse") #manipulating data
install.packages ("ggplot2") #create graphs
install.packages ("readxl") #reading in excel files

#load relevant packages
library (rmarkdown)
library (tidyverse)
library (ggplot2)
library (readxl)

# Read in data and cleaning ----

#Check relevant data sheets
sheet_names <- excel_sheets("Scotland_Fleet_data_by_segment.xlsx")

#Remove notes sheet
sheets_to_read <- sheet_names[-1]

#Import commercial fisheries economic data split by segment
for (sheet in sheets_to_read) {
  assign(sheet, read_excel("Scotland_Fleet_data_by_segment.xlsx", sheet = sheet, skip = 1))
}


