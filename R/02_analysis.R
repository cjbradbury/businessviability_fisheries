#Load in cleaned data ----
rm(list = ls())

library(tidyverse)

all_fleet_data <- readRDS(here::here("data", "processed", "all_fleet_data.rds"))

#explore indicators----

all_fleet_data |>
  distinct(indicator) |>
  print(n = Inf)

#rename fleet segment labels for outputs
fleet_segment_labels <- c(
  "Overall" = "Overall",
  "low_activity_o10m" = "Low activity, over 10m",
  "low_activity_u10m" = "Low activity, under 10m",
  "ns_nephrops_over_300k_w"= "North Sea nephrops, under 300kW",
  "wo_s_nephrops_o250k_w" = "North Sea nephrops, over 250kW",
  "ns_wo_s_demersal_u24m_o300k_w" = "NSWOS demersal, under 24m over 300kW",
  "ns_wo_s_demersal_seiners" = "NSWOS demersal seiners",
  "wo_s_nephrops_u250k_w" = "WOS nephrops, under 250kW",
  "pots_traps_o12m" = "Pots and traps, over 12m",
  "ns_wo_s_demersal_u24m_u300k_w" = "NSWOS demersal, under 24m under 300kW",
  "ns_wo_s_demersal_over_24m" = "NSWOS demersal, over 24m",
  "ns_wo_s_demersal_pair_trawl_seine" = "NSWOS demersal pair trawl seine",
  "u10m_demersal_trawl" = "Demersal trawl, under 10m",
  "ns_nephrops_under_300k_w" = "North Sea nephrops, under 300kW",
  "dredge_o15m" = "Dredge, over 15m",
  "pots_traps_10_12m" = "Pots and traps, 10-12m",
  "u10m_pots_traps" = "Pots and traps, under 10m",
  "longliners" = "Longliners",
  "dredge_u15m" = "Dredge, under 15m",
  "u10m_hooks" = "Hooks, under 10m"
  )

#group indicators based on type
viability_indicators <- c(
  "Operating Profit per vessel (£'000)",
  "Net Profit per vessel (£'000)",
  "Gross Value Added per vessel (£'000)"
)

income_cost_indicators <- c(
  "Avg. Fishing Income (£'000)",
  "Avg. Non Fishing Income (£'000)",
  "Avg. Total Income (£'000)",
  "Avg. Fuel costs (£'000)",
  "Avg. Crew share (£'000)",
  "Avg. Other Fishing Costs (£'000)",
  "Avg. Total Fishing Costs (£'000)",
  "Avg. Total Vessel Costs (£'000)",
  "Avg. Total Costs (£'000)"
)

cost_components <- c(
  "Avg. Fuel costs (£'000)",
  "Avg. Crew share (£'000)",
  "Avg. Other Fishing Costs (£'000)",
  "Avg. Total Vessel Costs (£'000)"
)

drivers_indicators <- c(
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
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(aes(
    x = year,
    y = value
  )) +
  geom_line() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  facet_wrap(
    ~ fleet_segment, 
    scales = "free_y", 
    labeller = labeller(fleet_segment = as_labeller(fleet_segment_labels, default = label_wrap_gen(width = 20)))
    ) +
  labs(
    x = "Year",
    y = "Operating profit per vessel (£'000)"
  )

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
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  )|>
  ggplot(aes(
    x = year,
    y = value
  )) +
  geom_line() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  facet_wrap(
    ~ fleet_segment, 
    scales = "free_y", 
    labeller = labeller(fleet_segment = as_labeller(fleet_segment_labels, default = label_wrap_gen(width = 20)))
  ) +
  labs(
    x = "Year",
    y = "Net profit per vessel (£'000)"
  )

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
#show table
profitability_summary

# Income and costs ----
# Income and cost data subset
income_cost_data <- all_fleet_data |>
  filter(indicator %in% income_cost_indicators)

# income vs costs
income_cost_plot <- income_cost_data |>
  filter(
    indicator %in% c(
      "Avg. Total Income (£'000)",
      "Avg. Total Costs (£'000)"
    )
  ) |>
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(aes(
    x = year,
    y = value,
    colour = indicator
  )) +
  geom_line() +
  facet_wrap(
    ~ fleet_segment, 
    scales = "free_y",
    labeller = labeller(
      fleet_segment = as_labeller(
        fleet_segment_labels,
        default = label_wrap_gen(width = 20)
      )
    )
    ) +
  labs(
    x = "Year",
    y = "£'000 per vessel",
    colour = NULL
  )

#operating profit margin to allow comparison of segments that have different scales
operating_margin_data <- all_fleet_data |>
  filter(
    indicator %in% c(
      "Operating Profit per vessel (£'000)",
      "Avg. Total Income (£'000)"
    )
  ) |> 
  select(
    fleet_segment,
    year,
    indicator,
    value
  ) |>
  pivot_wider(
    names_from = indicator,
    values_from = value
  ) |>
  mutate(
    operating_margin = 
      `Operating Profit per vessel (£'000)` /
      `Avg. Total Income (£'000)` * 100
  )
#Check code above has worked
glimpse (operating_margin_data)

#graphs split by segment
operating_margin_plot <- operating_margin_data |> 
  mutate(
  fleet_segment = fct_relevel(
    fleet_segment,
    "Overall",
    after = 0
  )
  ) |>
  ggplot(aes(
    x = year,
    y = operating_margin
  )) +
  geom_line() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  facet_wrap(~ fleet_segment, 
             scales = "free_y",
             labeller = labeller(fleet_segment = as_labeller(fleet_segment_labels, default = label_wrap_gen(width = 20)))
             ) +
  labs(
    x = "Year",
    y = "Operating profit margin (%)"
  )

#summary table
operating_margin_summary <- operating_margin_data |>
  group_by(fleet_segment) |>
  summarise(
    latest_year = max(year[!is.na(operating_margin)]),
    latest_margin = operating_margin[year == max(year[!is.na(operating_margin)])] [1],
    min_margin = min(operating_margin, na.rm = TRUE),
    max_margin = max(operating_margin, na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange( desc(fleet_segment == "Overall"),
           latest_margin
           )
#show table
operating_margin_summary

# Cost composition ----

#focus on just the cost composition indicators
cost_data <- income_cost_data |>
  filter(indicator %in% cost_components)

#see how costs have changed
cost_data |>
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(
    aes(
      x = year,
      y = value,
      colour = indicator
    )
  ) +
  geom_line() +
  facet_wrap(
    ~fleet_segment,
    scales = "free_y",
    labeller = labeller(
      fleet_segment = as_labeller(
        fleet_segment_labels,
        default = label_wrap_gen(width = 20)
      )
    ) 
    ) +
      labs(
        x = "Year",
        y = "Average cost per vessel (£'000)",
        colour = "Cost component"
      )

# cost shares of total cost
cost_share_data <- income_cost_data |>
  filter(
    indicator %in% c(
      "Avg. Fuel costs (£'000)",
      "Avg. Crew share (£'000)",
      "Avg. Other Fishing Costs (£'000)",
      "Avg. Total Vessel Costs (£'000)",
      "Avg. Total Costs (£'000)"
    )
  ) |>
  pivot_wider(
    names_from = indicator,
    values_from = value
  )

#calculate each component as a percentage of total costs
cost_share_data <- cost_share_data |>
  mutate(
    fuel_share =
      `Avg. Fuel costs (£'000)` /
      `Avg. Total Costs (£'000)` * 100,
    crew_share =
      `Avg. Crew share (£'000)` /
      `Avg. Total Costs (£'000)` * 100,
    other_fishing_share =
      `Avg. Other Fishing Costs (£'000)` /
      `Avg. Total Costs (£'000)` * 100,
    vessel_share =
      `Avg. Total Vessel Costs (£'000)` /
      `Avg. Total Costs (£'000)` * 100,
  )
#check shares add to 100%
cost_share_data <- cost_share_data |>
  mutate(
    total_share =
      fuel_share +
      crew_share +
      other_fishing_share +
      vessel_share
  )
summary(cost_share_data$total_share)

cost_share_long <- cost_share_data |>
  select(
    fleet_segment,
    year,
    fuel_share,
    crew_share,
    other_fishing_share,
    vessel_share
  ) |>
  pivot_longer(
    cols = ends_with("_share"),
    names_to = "cost_component",
    values_to = "cost_share"
  ) |>
  mutate(
    cost_component = recode(
      cost_component,
      "fuel_share" = "Fuel",
      "crew_share" = "Crew",
      "other_fishing_share" = "Other fishing",
      "vessel_share" = "Vessel"
    )
  )

cost_composition_plot <- cost_share_long |>
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(
    aes(
      x = year,
      y = cost_share,
      colour = cost_component
    )
  ) +
  geom_line() +
  facet_wrap(
    ~ fleet_segment,
    scales = "free_y",
    labeller = labeller(
      fleet_segment = as_labeller(
        fleet_segment_labels,
        default = label_wrap_gen(width = 20)
      )
    )
  ) +
  labs(
    x = "Year",
    y = "Share of total costs (%)",
    colour = "Cost component"
  )

#2025 cost data
cost_composition_summary <- cost_share_data |>
  filter(!is.na(`Avg. Total Costs (£'000)`)) |>
  group_by(fleet_segment) |>
  slice_max(
    year,
    n = 1,
    with_ties = FALSE
    )|>
  select(
    fleet_segment,
    year,
    fuel_share,
    crew_share,
    other_fishing_share,
    vessel_share
  ) |>
  arrange(desc(fleet_segment == "Overall"))

# Drivers of profitability ----
#Filter drivers data
drivers_data <- all_fleet_data |>
  filter(indicator %in% drivers_indicators)
#check
drivers_data |>
  distinct(indicator)

#landings per dat at sea
landings_per_day_plot <- drivers_data |>
  filter(indicator == "Average landings per day at sea (tonnes)") |>
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(aes(
    x = year,
    y = value
  )) +
  geom_line() +
  facet_wrap(
    ~ fleet_segment,
    scales = "free_y",
    labeller = labeller(
      fleet_segment = as_labeller(
        fleet_segment_labels,
        default = label_wrap_gen(width = 20)
      )
    )
  ) +
  labs(
    x = "Year",
    y = "Average landings per day at sea (tonnes)"
  )

#real price received
price_plot <- drivers_data |>
  filter(
    indicator == "Average price per tonne landed (£)"
  ) |>
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(aes(
    x = year,
    y = value
  )) +
  geom_line() +
  facet_wrap(
    ~ fleet_segment,
    scales = "free_y",
    labeller = labeller(
      fleet_segment = as_labeller(
        fleet_segment_labels,
        default = label_wrap_gen(width = 20)
      )
    )
  ) +
  labs(
    x = "Year",
    y = "Average price per tonne landed (£)"
  )

# Notes:
# - Catch productivity, measured by average landings per day at sea,
#   differs substantially across fleet segments and has generally
#   increased at the overall fleet level.
#
# - Trends are not uniform across segments; some show sustained increases
#   in landings per day while others are relatively stable or volatile.
#
# - Real prices per tonne also differ substantially across fleet segments,
#   reflecting differences in the species caught and fishing activity.
#
# - High tonnes landed per day should not therefore be interpreted
#   automatically as stronger economic performance. Lower-volume segments
#   can receive substantially higher prices per tonne.
#
# - Physical productivity and output value should therefore be considered
#   together when assessing income-generating capacity.

kw_day_data <- drivers_data |>
  filter(
    indicator %in% c(
      "Fishing income per kW day at sea (£)",
      "Total cost per kW day at sea (£)",
      "Operating profit per kW day at sea (£)"
    )
  )

#plot of kw_day_data
kw_day_plot <- kw_day_data |>
  mutate(
    fleet_segment = fct_relevel(
      fleet_segment,
      "Overall",
      after = 0
    )
  ) |>
  ggplot(aes(
    x = year,
    y = value,
    colour = indicator
    )
  ) +
  geom_line() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  facet_wrap(
    ~ fleet_segment,
    scales = "free_y",
    labeller = labeller(
      fleet_segment = as_labeller(
        fleet_segment_labels,
        default = label_wrap_gen(width = 20)
      )
    )
  ) +
  labs(
    x = "Year",
    y = "£ per kW day at sea",
    colour = NULL
  )
#table for the latest year
kw_day_summary <- kw_day_data |>
  filter(!is.na(value)) |>
  group_by(fleet_segment, indicator) |>
  slice_max(
    year,
    n = 1,
    with_ties = FALSE
  ) |>
  ungroup() |>
  select(
    fleet_segment,
    year,
    indicator,
    value
  ) |>
  pivot_wider(
    names_from = indicator,
    values_from = value
  )