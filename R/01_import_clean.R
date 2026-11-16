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

#rename first column to indicators
fleet_data <- map(
  fleet_data,
  ~ {
    names(.x)[1] <- "indicator"
    .x
  }
)

names(overall) <- names(fleet_data$longliners)

#convert to long format for easier analysis
fleet_data_long <- imap_dfr(
  fleet_data,
    \(data, segment_name) {
      data |>
        mutate(fleet_segment = segment_name) |>
        pivot_longer(
          cols = matches("^\\d{4}"),
          names_to = "year",
          values_to = "value",
        ) |>
        mutate(
          year = as.integer(str_remove(year, "\\*"))
        )
    }
  )

overall_long <- overall |>
  mutate(fleet_segment = "Overall") |>
  pivot_longer(
    cols = matches("\\d{4}"),
    names_to = "year",
    values_to = "value"
  ) |>
  mutate(
    year = as.integer(str_remove(year, "\\*"))
  )

all_fleet_data <- bind_rows(
  overall_long,
  fleet_data_long
)


# Checks----

overall_long |>
  distinct(indicator)

overall_long |>
  group_by(indicator) |>
  summarise(
    first_year = min(year[!is.na(value)]),
    latest_year = max(year[!is.na(value)]),
    n_missing = sum(is.na(value))
  ) |>
  print(n=40)

fleet_data_long |>
  group_by(fleet_segment, indicator) |>
  summarise(
    first_year = min(year[!is.na(value)]),
    latest_year = max(year[!is.na(value)]),
    n_missing = sum(is.na(value)),
    .groups = "drop"
  )

glimpse(all_fleet_data)

# Save data ----

saveRDS(
  all_fleet_data,
  "data/processed/all_fleet_data.rds"
)

