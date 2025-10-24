select 
    stock_name, 
    SUM(CASE WHEN operation = 'Sell' THEN price ELSE 0 END) 
    - SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) as capital_gain_loss
from Stocks
group by stock_name