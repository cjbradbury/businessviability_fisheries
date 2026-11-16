#Load in cleaned data ----
rm(list = ls())

library(tidyverse)

all_fleet_data <- readRDS("data/processed/all_fleet_data.rds")

#explore indicators----

all_fleet_data |>
  distinct(indicator) |>
  print(n = Inf)

#group indicators based on type
viability_indicators <- c(
  "Avg. Fishing Income (£'000)",
  "Avg. Total Income (£'000)",
  "Avg. Total Costs (£'000)",
  "Operating Profit per vessel (£'000)",
  "Net Profit per vessel (£'000)",
  "Gross Value Added per vessel (£'000)"
)

drivers_indicators <- c(
  "Avg. Fuel costs (£'000)",
  "Avg. Crew share (£'000)",
  "Avg. Other Fishing Costs (£'000)",
  "Average price per tonne landed (£)",
  "Average landings per day at sea (tonnes)",
  "Fishing income per kW day at sea (£)",
  "Total cost per kW day at sea (£)",
  "Operating profit per kW day at sea (£)"
)

structure_indicators <- c(
  "Number of vessels",
  "FTEs",
  "Average length (m)",
  "Average VCU",
  "Average Vessel Age (year)"
)

activity_indicators <- c(
  "Landings (tonnes)",
  "Days at Sea (days)",
  "Average Landings (tonnes)",
  "Average Days at Sea",
  "Average landings per day at sea (tonnes)",
  "Landings per kW day at sea (kg)"
)

#Viability indicators----

viability_data <- all_fleet_data |>
  filter(indicator %in% viability_indicators)

#Operating Profit per vessel (£'000)
#all segments on one graph
viability_data |>
  filter(indicator == "Operating Profit per vessel (£'000)") |>
  ggplot(aes(
    x = year,
    y = value,
    colour = fleet_segment
  )) +
  geom_line() +
  geom_hline( yintercept = 0, linetype = "dashed") +
  labs(
    x = "Year",
    y = "Operating profit per vessel (£'000)",
    colour = "Fleet segment"
  )

#individual graph for each segment
operating_profit_plot <- viability_data |>
  filter(indicator == "Operating Profit per vessel (£'000)") |>
  ggplot(aes(
    x = year,
    y = value
  )) +
  geom_line() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  facet_wrap(~ fleet_segment, scales = "free_y") +
  labs(
    x = "Year",
    y = "Operating profit per vessel (£'000)"
  )
#Notes:
# - Large variation in operating profit between fleet segments.
# - Overall trend masks considerable variation between segments.
# - Low-activity >10m segment appears loss-making in multiple years.
# - Some larger demersal segments have much higher but more volatile profits.
# - Need to consider whether vessel size is driving differences in profit per vessel.
# - Profitability does not necessarily mean resilience to displacement.

#convert data into a tibble
operating_profit_summary <- viability_data |>
  filter(indicator == "Operating Profit per vessel (£'000)") |>
  group_by(fleet_segment) |>
  summarise(
    latest_year = max(year[!is.na(value)]),
    latest_available_profit = value[year == max(year[!is.na(value)])][1],
    min_profit = min(value, na.rm = TRUE),
    max_profit = max(value, na.rm = TRUE),
    loss_years = sum(value <0, na.rm = TRUE),
    years_available = sum(!is.na(value)),
    .groups = "drop"
  ) |>
  mutate(
    loss_year_pct = 100 * loss_years / years_available
  ) |>
  arrange (latest_available_profit)

operating_profit_summary
#Notes:
# - Operating profitability varies substantially across fleet segments.
# - Low-activity >10m vessels recorded negative average operating profit
#   in every observed year
# - Low-activity <10m vessels operate close to break-even and recorded
#   losses in 4 of 18 years
# - Most other segments recorded no years of negative average operating
#   profit over the time series
# - Absolute profit levels differ substantially across segments, so higher
#   operating profit should not automatically be interpreted as greater
#   resilience to displacement.
# - One segment has data only to 2021, therefore latest avaialable values
#   are not directly comparable across all segments.

#Net Profit per vessel (£'000)
#all segments on one graph
viability_data |>
  filter(indicator == "Net Profit per vessel (£'000)") |>
  ggplot(aes(
    x = year,
    y = value,
    colour = fleet_segment
  )) +
  geom_line() +
  geom_hline( yintercept = 0, linetype = "dashed") +
  labs(
    x = "Year",
    y = "Net profit per vessel (£'000)",
    colour = "Fleet segment"
  )

#individual graph for each segment
net_profit_plot <- viability_data |>
  filter(indicator == "Net Profit per vessel (£'000)") |>
  ggplot(aes(
    x = year,
    y = value
  )) +
  geom_line() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  facet_wrap(~ fleet_segment, scales = "free_y") +
  labs(
    x = "Year",
    y = "Net profit per vessel (£'000)"
  )
# Notes:
# - Large variation in Net profit between fleet segments.
# - Low-activity >10m is the weakest segment with net profit consistently
#   below zero, and significant loss early in the series.
# - Low-activity <10m is much closer to zero but still negative net profit
# - Some segments with consistently positive operating profit move below
#   zero on net profit
# - Overall remains positive but that aggregate conceals the differences

#convert data into a tibble
net_profit_summary <- viability_data |>
  filter(indicator == "Net Profit per vessel (£'000)") |>
  group_by(fleet_segment) |>
  summarise(
    latest_year = max(year[!is.na(value)]),
    latest_available_profit = value[year == max(year[!is.na(value)])][1],
    min_profit = min(value, na.rm = TRUE),
    max_profit = max(value, na.rm = TRUE),
    loss_years = sum(value <0, na.rm = TRUE),
    years_available = sum(!is.na(value)),
    .groups = "drop"
  ) |>
  mutate(
    loss_year_pct = 100 * loss_years / years_available
  ) |>
  arrange (latest_available_profit)

net_profit_summary
# Notes:
# - low activity, nephrops_over_300kw, nephrops_o250kw have persistent or
#   frequent net losses.
# - demersal u24m and longliners have had losses in the past but currently
#   profitable.
# - Overall and u10m demersal, u10m pots and traps, have had consistent profit

#Combined profitability table
profitability_summary <- operating_profit_summary |>
  select(
    fleet_segment,
    operating_latest_year = latest_year,
    operating_profit = latest_available_profit,
    operating_loss_pct = loss_year_pct
  ) |>
  left_join(
    net_profit_summary |>
      select(
        fleet_segment,
        net_latest_year = latest_year,
        net_profit = latest_available_profit,
        net_loss_pct = loss_year_pct
      )
  )

profitability_summary

# Provisional profitability findings ----

# 1. Profitability varies substantially across fleet segments, both in
#    absolute level and stability over time.

# 2. Low-activity >10m vessels show the clearest evidence of persistent
#    financial pressure: average operating profit is negative throughout
#    the observed period and net profit is negative in every year for
#    which a valid net-profit estimate is available

# 3. Low-activity <10m vessels operate much closer to break-even and 
#    experience frequent net losses, despite the relatively small
#    absolute size of those losses.

# 4. Some segments with high current or recent profitability have also
#    experienced substantial historical variation and periods of net 
#    loss. Current profit alone therefore does not capture the stability
#    of financial performance.

# 5. The Overall series masks substantial differences between fleet
#    segments and should therefore be treated primarily as a benchmark.

# 6. These results describe historical profitability rather than directly
#    measuring resilience to displacement or spatial squeeze. Profitability
#    should be considered alongside costs, activity and productivity before
#    drawing conclusions about business viability.

# Data note:
# Valid net-prfoti estimates are not avialble for 2025 because depreciation,
# interest and other finance costs are unavailable. Net-profit analysis
# therefore ends in 2024 for most fleet segments.
