# FUTURE_DS_01: Business Sales Performance Analytics

Task 1 of the Data Science & Analytics Internship at Future Interns.

**Goal:** Analyze business sales data to find revenue trends, top-selling products, high-value categories and regional performance, then turn the findings into clear, actionable recommendations.

**Author:** Toby Obidike

---

## Dashboard

The full Power BI dashboard is in [`FUTURE_DS_01_dashboard.pdf`](FUTURE_DS_01_dashboard.pdf) (2 pages). The editable file is `FUTURE_DS_01_dashboard.pbix`.

It contains:

- KPI cards: total sales, total profit, profit margin, orders, average order value
- Monthly sales and profit trend (2014-2017)
- Profit by sub-category
- Profit margin by region
- Profit by discount level
- A key insights and recommendations box

---

## Dataset

- **Source:** Superstore Sales dataset (Kaggle)
- **Size:** 9,994 rows, 21 columns, covering January 2014 to December 2017
- **Quality checks:** no missing values and no duplicate rows
- **Notes:** the file uses latin1 encoding and dates in M/D/YYYY format

---

## Tools

| Stage | Tool |
|---|---|
| Cleaning and analysis | R (tidyverse) in RStudio |
| Dashboard | Power BI Desktop |
| Documentation | GitHub |

---

## Method

1. **Load and clean:** read the CSV with latin1 encoding, standardized the column names (for example `Order Date` became `order_date`), and converted the dates to real date values.
2. **Save a clean copy** (`superstore_clean.csv`) for Power BI.
3. **Calculate KPIs:** total sales, total profit, profit margin, number of orders and average order value.
4. **Analyze** sales and profit by year, month, product, category and sub-category, region, and discount level.
5. **Test a hypothesis:** whether heavy discounting explains the weak profit areas (see the last finding below).
6. **Build the dashboard** in Power BI, using DAX measures for the KPIs.

---

## Key Results

| KPI | Value |
|---|---|
| Total sales | $2.30M |
| Total profit | $286.4K |
| Profit margin | 12.47% |
| Orders | 5,009 |
| Average order value | $458.61 |

### Findings

1. **Strong growth with a seasonal peak.** Sales dipped slightly in 2015 (-2.8%), then grew about 30% in 2016 and 20% in 2017, reaching $733K. September to December brings in about half of each year's sales, and November 2017 was the biggest month (about $118K). January and February are the weakest months.
2. **Technology and Office Supplies drive profit; Furniture does not.** Furniture is about 32% of sales but only about 6% of profit (a 2.5% margin), while the other two categories earn margins of roughly 17%.
3. **Three sub-categories lose money.** Tables (-$17.7K), Bookcases (-$3.5K) and Supplies (-$1.2K). Machines sell $189K but earn only a 1.8% margin.
4. **Copiers are the profit engine.** They earn a 37% margin and the highest profit of any sub-category ($55.6K). The Canon imageCLASS 2200 copier alone earns $25.2K.
5. **Some top sellers are not profitable.** The Cisco TelePresence EX90 (-$1.8K) and GBC DocuBind P400 (-$1.9K) are in the top 10 by sales but lose money.
6. **Central is the weakest region.** It earns a 7.9% margin, against 14.9% in West, 13.5% in East and 11.9% in South.
7. **Heavy discounting destroys profit.** Rows with no discount earn a 29.5% margin. Every discount level of 30% or more loses money: those 1,393 rows (about 14% of the data) lost roughly $135K in total.
8. **Discounting explains much, but not all, of the weak areas.** Central has the heaviest discounting (24% average, with 27.7% of items at 30% or more, against 3.7% in West), and Tables, Bookcases and Machines are among the most discounted sub-categories. However, Binders are heavily discounted yet profitable, Supplies lose money with a low discount rate, and East has a high share of heavy discounts but a healthy margin. Other factors, such as product costs and pricing, probably contribute and were not tested here.

---

## Recommendations

- **Cap discounts at around 20-30%.** Beyond that, the business loses money on each sale.
- **Review pricing and discounts on Tables and Bookcases**, or reduce how much of the range is sold at a discount.
- **Protect and promote high-margin lines**, especially Copiers, Accessories and Paper.
- **Investigate Central's pricing and discount practice**, since that is where the margin gap is.
- **Plan around the seasonal peak:** build stock and campaigns ahead of September to November, and run promotions in January and February to fill the quiet months.

---

## Repository Contents

| File | Description |
|---|---|
| `FUTURE_DS_01_dashboard.pdf` | Dashboard export (2 pages) |
| `FUTURE_DS_01_dashboard.pbix` | Power BI file |
| `analysis.R` | R code for cleaning and analysis |
| `Sample - Superstore.csv` | Original dataset |
| `superstore_clean.csv` | Cleaned dataset used by Power BI |
| `README.md` | This file |

---

## How to Reproduce

1. Install R and RStudio, then install the tidyverse package: `install.packages("tidyverse")`
2. Put `Sample - Superstore.csv` in a folder and update the `path` line at the top of `analysis.R` to match its location.
3. Run `analysis.R` to clean the data and print the analysis tables.
4. Open `FUTURE_DS_01_dashboard.pbix` in Power BI Desktop (it loads `superstore_clean.csv`; if prompted, point it to your copy of the file).

---

## Power BI Measures (DAX)

```
Total Sales = SUM(superstore_clean[sales])
Total Profit = SUM(superstore_clean[profit])
Profit Margin = DIVIDE([Total Profit], [Total Sales])
Orders = DISTINCTCOUNT(superstore_clean[order_id])
Avg Order Value = DIVIDE([Total Sales], [Orders])
```

Calculated columns used for the charts:

```
Month Start = DATE(YEAR(superstore_clean[order_date]), MONTH(superstore_clean[order_date]), 1)

Discount Band = SWITCH(TRUE(), superstore_clean[discount] = 0, "1. No discount", superstore_clean[discount] <= 0.2, "2. Up to 20%", superstore_clean[discount] <= 0.5, "3. 30% to 50%", "4. 60% to 80%")
```
