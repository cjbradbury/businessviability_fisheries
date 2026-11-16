#Set up ----

#clear all objects
rm(list = ls()) 

#load required packages
library (rmarkdown) #creating rmarkdown files
library (tidyverse) #manipulating data
library (readxl) #reading in excel files
library (janitor) # clean

# Read in data and cleaning ----

#Check relevant data sheets
overall <- read_excel("data/raw/Scotland_Fleet_data.xlsx") |> 
  clean_names()
names(overall)[1] <- "indicator"


file <- "data/raw/Scotland_Fleet_data_by_segment.xlsx"

#Remove notes, and port sheet
sheets <- excel_sheets(file)
sheets <- sheets[-c(1, length(sheets))]

#Import commercial fisheries economic data split by segment
fleet_data <- map(
  sheets,
  ~ read_excel(
    file,
    sheet = .x,
    skip = 1
  )
)

names(fleet_data) <- sheets

#clean the names
names(fleet_data) <- make_clean_names(names(fleet_data))

#create a new column so that all data frames have the same number of columns
fleet_data$ns_wo_s_demersal_u24m_u300k_w[["2025*"]] <- NA_real_ 

fleet_data$overall <- overall
rm(overall)

#rename first column to indicators
fleet_data <- map(
  fleet_data,
  ~ {
    names(.x)[1] <- "indicator"
    .x
  }
)

#remove any leading or trailing space in the indicator names
fleet_data <- map(
  fleet_data,
  ~ mutate(
    .x,
    indicator = trimws(indicator)
  )
)

#make sure column names in overall are the same as the others
names(fleet_data$overall) <- names(fleet_data$longliners)



# Checks----

#check column names
names(fleet_data$longliners)

#check column names in all sheets are the same
map(fleet_data, names)

#check data
glimpse(fleet_data$longliners)

#check to see how many NA's there are
map(fleet_data, ~ colSums(is.na(.x)))

# Save data ----

saveRDS(
  fleet_data,
  "data/processed/fleet_data.rds"
)

