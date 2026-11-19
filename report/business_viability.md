---
title: "Business Viability of Commercial Fisheries"
output: 
  html_document: 
    keep_md: true
date: "2026-11-16"
---


# Profitability

Profitability provides an indication of the financial performance of different fleet segments over time. Operating profit is considered alongside net profit because the two measures capture different aspects of financial performance. Operating profit reflects the performance of fishing operation before depreciation, interest and financing costs, while net profit also includes these things.

The analysis considers both the latest available profitability estimates and the frequency with which average vessels within each fleet segment have recorded losses over the available time series.


Table: Table 1: Profitability indicators by fleet segment

|Fleet segment                         | Operating profit year| Operating profit (£'000)| Years with operating loss (%)| Net profit year| Net profit (£'000)| Years with net loss (%)|
|:-------------------------------------|---------------------:|------------------------:|-----------------------------:|---------------:|------------------:|-----------------------:|
|Overall                               |                  2025|                    148.7|                           0.0|            2024|              109.4|                     0.0|
|Low activity, over 10m                |                  2025|                     -3.3|                         100.0|            2024|              -13.4|                   100.0|
|Low activity, under 10m               |                  2025|                      0.0|                          22.2|            2024|               -1.0|                    64.7|
|Demersal trawl, under 10m             |                  2025|                     12.9|                           0.0|            2024|                5.8|                     0.0|
|Pots and traps, under 10m             |                  2025|                     20.3|                           0.0|            2024|               13.1|                     0.0|
|Hooks, under 10m                      |                  2025|                     27.1|                           0.0|            2024|               25.9|                     5.9|
|WOS nephrops, under 250kW             |                  2025|                     31.9|                           0.0|            2024|               14.1|                     5.9|
|North Sea nephrops, under 300kW       |                  2025|                     37.1|                           0.0|            2024|               21.1|                    11.8|
|NSWOS demersal, under 24m under 300kW |                  2021|                     41.3|                           0.0|            2021|               20.1|                     0.0|
|Pots and traps, 10-12m                |                  2025|                     43.4|                           0.0|            2024|               22.9|                     0.0|
|North Sea nephrops, over 250kW        |                  2025|                     53.4|                           5.6|            2024|              -11.3|                    41.2|
|Dredge, under 15m                     |                  2025|                     55.4|                           0.0|            2024|               41.4|                    17.6|
|Pots and traps, over 12m              |                  2025|                     66.5|                           0.0|            2024|               41.8|                     5.9|
|NSWOS demersal, under 24m over 300kW  |                  2025|                    104.9|                           0.0|            2024|              -26.4|                    35.3|
|North Sea nephrops, under 300kW       |                  2025|                    106.1|                           0.0|            2024|              -61.8|                    52.9|
|Longliners                            |                  2025|                    160.2|                           5.6|            2024|              156.5|                    23.5|
|NSWOS demersal seiners                |                  2025|                    204.0|                           0.0|            2024|              -54.3|                    17.6|
|Dredge, over 15m                      |                  2025|                    217.0|                           0.0|            2024|              105.2|                     5.9|
|NSWOS demersal pair trawl seine       |                  2025|                    387.9|                           0.0|            2024|              111.9|                     5.9|
|NSWOS demersal, over 24m              |                  2025|                    438.6|                           0.0|            2024|              -45.8|                    17.6|

Table 1 highlights substantial differences in both the level and consistency of profitability across fleet segments. While most segments recorded positive operating profit in the latest available year, the frequency of historical losses varies considerably between segments. The differences are more pronounced for net profit, with several segments experiencing net losses in a meaningful proportion of observed years despite recording positive operating profits.

This distinction is important because the latest available profit provides only a snapshot of financial performance. The proportion of years in which losses were recorded provides additional evidence on the persistence and stability of profitability over time. The results therefore suggest that assessments of business viability should consider both the current financial position and historical variability rather than relying on a single year's profitability.

## Operating profit


```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![Figure 1: Operating profit per vessel by fleet segment over time](business_viability_files/figure-html/operating-profit-figure-1.png)

Figure 1 shows substantial variation in operating profit per vessel across fleet segments and over time. Some larger demersal segments generate operating profits considerably above the fleet average, while smaller-vessel segments generally generate much lower absolute profits per vessel. This partly reflects differences in the scale and characteristics of fishing businesses and means that absolute profit levels should be interpreted cautiously when comparing segments.

Operating profitability also varies considerably over time for some fleet segments. Several segments experience pronounced increases and decreases in operating profit rather than a consistent trend, while others show comparatively stable performance. The Scotland-level series remains positive throughout the period and generally increases over the longer term, but this aggregate trend masks substantial differences between individual segments.

## Net profit


```
## Warning: Removed 23 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![Figure 2: Net profit per vessel by fleet segment over time](business_viability_files/figure-html/net-profit-plot-1.png)

**Data note:** Valid net profit estimates are not available for 2025 because depreciation, interest and other finance costs are not available for that year. Net profit analysis therefore ends in 2024 for most fleet segments. The latest available year also differs for some individual segments where data are unavailable.

Figure 2 shows that the financial position of some fleet segments becomes weaker when depreciation, interest and other finance costs are taken into account. Periods of negative net profit occur more frequently than periods of negative operating profit, indicating that positive returns from fishing operations do not necessarily translate into positive overall financial returns once these additional costs are included.

There is also considerable variation in net profit over time. Some segments move between positive and negative net profitability across the period, including segments that generate relatively high operating profits. This suggests that both the level and stability of profitability are relevant when considering financial viability. Persistent or recurring losses may indicate greater financial pressure, while consistently positive net profitability provides stronger evidence of sustained financial performance.

## Operating profit margin

Absolute operating profit differs substantially across fleet segments, in part reflecting differences in the scale and characteristics of fishing businesses. Operating profit margin provides an additional measure that accounts for these differences in scale by expressing operating profit per vessel as a proportion of average total income per vessel.


```
## Warning: Removed 4 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![Figure 3: Operating profit margin per vessel by fleet segment over time](business_viability_files/figure-html/operating-margin-plot-1.png)

Operating margins vary considerably across fleet segments and over time. The overall fleet operating margin increased over the period and was approximately 31% in 2025. Several smaller-vessel segments have relatively high operating margins despite generating substantially lower operating profit per vessel in real terms. For example, the under-10 metre hooks segment had a n operating margin of approximately 45% in 2025.

Conversely, some larger demersal and nephrops segments generated substantially higher absolute operating profits but had lower operating margins. This shows that higher operating profit per vessel does not necessarily imply stronger profitability relative to the scale of the business.

## Findings

Profitability varies substantially across fleet segments, both in the level of profit generated and its stability over time. The overall Scotland-level results mask considerable differences between individual fleet segments.

The profitability measures provide different perspectives on financial performance. Absolute operating profit shows the size of the financial surplus generated per vessel, while operating margin provides an indication of this surplus relative to income. Several smaller-vessel segments have relatively strong operating margins despite substantially lower absolute profits, demonstrating the importance of considering both measures.

Some fleet segments with positive profits in the latest available year experienced net losses relatively frequently over the historical period. This indicates that a single year's profitability does not fully represent the stability of financial performance within each segment.

The low-activity fleet exhibits particularly weak or volatile profitability, although these categories are not the primary focus of this assessment.

High absolute profitability should also not automatically be interpreted as evidence of greater resilience. Some higher-profit fleet segments display substantial year-to-year variation and have experienced periods of negative net profitability.

These findings provide evidence on historical financial performance rather than a direct measure of resilience to spatial displacement. Profitability therefore needs to be considered alongside income and costs, fishing activity, productivity and fleet characteristics before drawing wider conclusions about the capacity of different fleet segments to absorb additional spatial pressures.

# Income and costs

Income and costs provide additional context for the profitability results by showing how the financial position of different fleet segments has developed over time. All financial values are expressed in 2025 prices using the GDP deflator, meaning changes over time represent changes in real rather than nominal values.

## Income and total costs


```
## Warning: Removed 8 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![Figure 4: Total Income and total costs  per vessel by fleet segment over time](business_viability_files/figure-html/income-cost-plot-1.png)

Figure 4 shows substantial differeneces in the scale of income and costs across fleet segments. This reflects differences in vessel size, activity and business characteristics and means that absolute financial values should be interpreted cautiously when comparing segments.

Across much of the fleet, average total income generally remains above average total costs, consistent with the predominantly positive operating profits identified in the profitability analysis. However, the gap between income and costs varies considerably across fleet segments and over time. Some segments also experience relatively large year-to-year movements in real income compared with costs, contributing to the variation in profitability observed over the period.

The overall fleet position therefore masks substantial differences in the financial experience of individual fleet segments.

## Cost composition

The composition of total costs also vaires across the fleet. Table 2 presents each major cost component as a percentage of average total costs, allowing cost structures to be compared across fleet segments of substantially different sizes.


Table: Table 2: Composition of average total costs by fleet segment, latest available year

|Fleet segment                         | Latest year| Fuel (%)| Crew (%)| Other fishing (%)| Vessel (%)|
|:-------------------------------------|-----------:|--------:|--------:|-----------------:|----------:|
|Overall                               |        2025|     12.7|     42.2|              19.8|       25.3|
|Dredge, over 15m                      |        2025|     18.2|     42.7|               8.7|       30.4|
|Dredge, under 15m                     |        2025|     17.4|     34.5|              10.8|       37.3|
|Longliners                            |        2025|     13.3|     51.3|               9.2|       26.2|
|Low activity, over 10m                |        2025|      8.0|      7.9|              37.6|       46.5|
|Low activity, under 10m               |        2025|      5.9|     24.7|              16.2|       53.2|
|North Sea nephrops, under 300kW       |        2025|     19.7|     34.1|              22.1|       24.0|
|North Sea nephrops, under 300kW       |        2025|     13.1|     35.9|               7.5|       43.5|
|NSWOS demersal, over 24m              |        2025|     19.1|     31.1|              29.2|       20.5|
|NSWOS demersal pair trawl seine       |        2025|      8.7|     40.0|              30.2|       21.1|
|NSWOS demersal seiners                |        2025|     12.8|     31.0|              26.2|       30.1|
|NSWOS demersal, under 24m over 300kW  |        2025|     15.4|     24.3|              30.4|       30.0|
|NSWOS demersal, under 24m under 300kW |        2021|     18.4|     35.4|              20.2|       26.0|
|Pots and traps, 10-12m                |        2025|      8.0|     30.8|              25.3|       36.0|
|Pots and traps, over 12m              |        2025|      9.3|     44.0|              18.7|       28.1|
|Demersal trawl, under 10m             |        2025|     16.6|     42.3|              12.4|       28.7|
|Hooks, under 10m                      |        2025|      3.8|     31.8|              20.8|       43.7|
|Pots and traps, under 10m             |        2025|      4.9|     39.6|              23.4|       32.0|
|North Sea nephrops, over 250kW        |        2025|     16.4|     40.4|              12.6|       30.6|
|WOS nephrops, under 250kW             |        2025|     15.0|     37.7|              16.9|       30.4|


```
## Warning: Removed 16 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![Figure 5: Composition of average total costs by fleet segment over time](business_viability_files/figure-html/cost-composition-figure-1.png)

Crew costs account for substantial proportion of total costs across much of the fleet. For the overall fleet, crew costs accounted for approximately 42% of average total costs in 2025, compared with approximately 25% for vessel costs, 20% for other fishing costs and 13% for fuel.

However, this overall cost structure masks considerable difference between fleet segments. Fuel costs represent a relatively larger share of total costs for some demersal and nephrops segments, while fuel accounts for a much smaller proportion of costs for some passive-gear segments. Vessel costs are correspondingly more important for a number of these segments. Vessel costs are correspondingly more important for a number of these segments. Other fishing costs also represent a substantial share of total costs for several demersal segments.

Figure 5 shows that cost structures are not fixed over time. The relative importance of fuel, crew, other fishing and vessel costs has changed within a number of fleet segments. This means that different segments may be exposed to different forms of cost pressure, and that exposure can itself change over time.

Differences in cost composition may also be relevant when considering potential displacement pressures. For example, fleet segments for which fuel represents a larger proportion of costs could be more exposed to changes that increase steaming requirements. However, the cost data describe existing cost structures and do not in themselves demonstrate the effect of future spatial displacement.
