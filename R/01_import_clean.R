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

overall |>
  distinct(indicator) |>
  print(n = Inf)

overall <- overall |>
  mutate(
    indicator = recode(
      indicator,
      "Number of active vessels" = "Number of vessels",
      "Vessel Capacity Units (VCU)" = "VCU (unit)",
      "Fishing income (£'M)" = "Fishing Income (£ million)",
      "Days at sea" = "Days at Sea (days)",
      "Fuel consumption ('000 litres)" = "Fuel Consumption (thousand litres)",
      "Employment (FTE)" = "FTEs",
      "Average Length (m)" = "Average length (m)",
      "Average Power (kW)" = "Average power (kW)",
      "Average Vessel Capacity Units (VCU)" = "Average VCU",
      "Average Days at sea (days)" = "Average Days at Sea",
      "Average Vessel age (years)" = "Average Vessel Age (year)",
      "Average Landings per day at sea (tonnes)" = "Average landings per day at sea (tonnes)",
      "Average Price per tonne landed (£)" = "Average price per tonne landed (£)",
      "Landings by kW day at sea (kg)" = "Landings per kW day at sea (kg)",
      "Fishing Income per kW day at sea (£)" = "Fishing income per kW day at sea (£)",
      "Cost per kW day at sea (£)" = "Total cost per kW day at sea (£)",
      "Fishing Income" = "Avg. Fishing Income (£'000)",
      "Non-fishing income (£'000)" = "Avg. Non Fishing Income (£'000)",
      "Income" = "Avg. Total Income (£'000)",
      "Fuel costs" = "Avg. Fuel costs (£'000)",
      "Crew share" = "Avg. Crew share (£'000)",
      "Other fishing costs" = "Avg. Other Fishing Costs (£'000)",
      "Total fishing costs (£'000)" = "Avg. Total Fishing Costs (£'000)",
      "Total vessel costs" = "Avg. Total Vessel Costs (£'000)",
      "Total costs (£'000)" = "Avg. Total Costs (£'000)",
      "Gross value added (£'000)" = "Gross Value Added per vessel (£'000)",
      "Operating profit per vessel (£'000)" = "Operating Profit per vessel (£'000)",
      "Depreciation (£'000)" = "Depreciation per vessel (£'000)",
      "Interest (£'000)" = "Interest per vessel (£'000)",
      "Other finance costs (£'000)" = "Other Finance Costs per vessel (£'000)",
      "Net profit (£'000)" = "Net Profit per vessel (£'000)"
    )
  )

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

