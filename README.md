# Cowrywise - DataAnalytics-Assessment

### Assessment Q1: High-Value Customers with Multiple Products

**Approach:**
- Joined the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables to connect customers, their plans, and transactions
- Used conditional aggregation with `COUNT(DISTINCT CASE WHEN...)` to count savings and investment plans separately
- Applied a HAVING clause to filter only customers with at least one of each plan type
- Converted kobo to naira by dividing by 100 as specified in the hints
- Sorted by total deposits in descending order to highlight high-value customers

### Assessment Q2: Transaction Frequency Analysis

**Approach:**
- Created a CTE (Common Table Expression) to calculate each customer's transaction frequency
- Used `DATEDIFF(MONTH, MIN(u.date_joined), CURRENT_DATE)` to determine the customer's tenure in months
- Calculated average transactions per month for each customer by dividing total transactions by tenure
- Added a CASE statement to categorize customers based on their transaction frequency
- Applied `NULLIF()` to prevent division by zero errors for new customers
- Aggregated results by frequency category to get the required metrics

### Assessment Q3: Account Inactivity Alert

**Approach:**
- Created a CTE to find the most recent transaction date for each account
- Used `DATEDIFF(DAY, MAX(s.date_created), CURRENT_DATE)` to calculate inactivity days
- Added a CASE statement to identify account types (Savings or Investment)
- Filtered accounts with either no transactions or last transaction older than 365 days
- Included accounts with NULL last_transaction_date which indicates no transactions at all
- Sorted by inactivity days to prioritize the most inactive accounts

### Assessment Q4: Customer Lifetime Value (CLV) Estimation

**Approach:**
- Created a CTE to calculate customer metrics including tenure, transaction count, and deposit value
- Calculated profit as 0.1% of transaction value (converted from kobo to naira)
- Computed the CLV using the provided formula: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction
- Used a WHERE clause to filter out customers with zero tenure to avoid division by zero
- Rounded the CLV to two decimal places for readability
- Sorted by estimated CLV in descending order to identify the most valuable customers

## Challenges

### Data Format Conversion
- The hints mentioned that all amount fields are in kobo (1/100 of the naira), requiring conversion in the queries by dividing by 100

### Foreign Key Relationships
- Understanding and properly joining the tables based on the foreign key relationships was essential for accurate results
- Used the hints to identify that owner_id references users.id and plan_id references plans.id

### Date Calculations
- Ensuring proper date calculations for tenure and inactivity periods required careful use of DATEDIFF with appropriate time units
- Handled edge cases like NULL transaction dates and zero tenure months

### Performance Considerations
- Used appropriate indexing hints in the queries where applicable