library(tidyverse)
path <- "C:/Users/toby/Downloads/internship/Sample - Superstore.csv"
stopifnot(file.exists(path))

store <- read_csv(path, locale = locale(encoding = "latin1"))
names(store) <- tolower(gsub("[ -]", "_", names(store)))
store$order_date <- mdy(store$order_date)
store$ship_date <- mdy(store$ship_date)

write_csv(store, "C:/Users/toby/Downloads/internship/superstore_clean.csv")

# Main numbers
glimpse(store)
sum(store$sales)
sum(store$profit)
sum(store$profit) / sum(store$sales)
n_distinct(store$order_id)

# 1. Sales and profit by year
store %>%
  group_by(year = year(order_date)) %>%
  summarise(sales = round(sum(sales)), profit = round(sum(profit)),
            margin = round(sum(profit) / sum(sales), 3),
            orders = n_distinct(order_id)) %>%
  print(n = Inf)

# 2. Sales by month
store %>%
  group_by(month = floor_date(order_date, "month")) %>%
  summarise(sales = round(sum(sales))) %>%
  print(n = Inf)

# 3. Top 10 products by sales
store %>%
  group_by(product_name) %>%
  summarise(sales = round(sum(sales)), profit = round(sum(profit))) %>%
  arrange(desc(sales)) %>%
  head(10) %>%
  print(n = Inf, width = Inf)

# 4. Category and sub-category
store %>%
  group_by(category, sub_category) %>%
  summarise(sales = round(sum(sales)), profit = round(sum(profit)),
            margin = round(sum(profit) / sum(sales), 3), .groups = "drop") %>%
  arrange(desc(sales)) %>%
  print(n = Inf)

# 5. Region
store %>%
  group_by(region) %>%
  summarise(sales = round(sum(sales)), profit = round(sum(profit)),
            margin = round(sum(profit) / sum(sales), 3)) %>%
  arrange(desc(sales)) %>%
  print(n = Inf)

# 6. Discount vs profit
store %>%
  group_by(discount) %>%
  summarise(rows = n(), profit = round(sum(profit)),
            margin = round(sum(profit) / sum(sales), 3)) %>%
  print(n = Inf)
#Average discount by region
store %>% group_by(region) %>%
  summarise(avg_discount = round(mean(discount), 3))
#Average discount and profit by sub-category
store %>% group_by(sub_category) %>%
  summarise(avg_discount = round(mean(discount), 3), profit = round(sum(profit))) %>%
  arrange(desc(avg_discount)) %>%
  print(n = Inf)
#Average discount and share of heavy discounts (30%+) by region
store %>% group_by(region) %>%
  summarise(avg_discount = round(mean(discount), 3),
            share_over_30 = round(mean(discount >= 0.3), 3))