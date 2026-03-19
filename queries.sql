SELECT *
FROM sales_data
LIMIT 10;

--1:Xem tổng số đơn hàng
SELECT COUNT(*) AS total_orders
FROM sales_data;

--2:Có bao nhiêu quốc gia bán hàng
SELECT COUNT(DISTINCT country) AS total_countries
FROM sales_data;

--3:Doanh thu theo quốc gia
SELECT country,SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY country
ORDER BY total_revenue DESC;

--4:Top 10 sản phẩm bán nhiều nhất
SELECT product,SUM(order_quantity) AS total_quantity
FROM sales_data
GROUP BY product
ORDER BY total_quantity DESC
LIMIT 10;

--5:Doanh thu theo nhóm tuổi
SELECT age_group,SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY age_group
ORDER BY total_revenue DESC;

--6:Category nào có doanh thu > 10 triệu
SELECT product_category,SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY product_category
HAVING SUM(revenue) > 10000000
ORDER BY total_revenue DESC;

--7:Doanh thu từ năm 2015 trở đi
SELECT year,SUM(revenue) AS revenue
FROM sales_data
WHERE year >= 2015
GROUP BY year
ORDER BY year;

--8:Top 5 sản phẩm có lợi nhuận cao nhất
SELECT product,SUM(profit) AS total_profit
FROM sales_data
GROUP BY product
ORDER BY total_profit DESC
LIMIT 5;

--9:Xếp hạng sản phẩm theo doanh thu
SELECT product,SUM(revenue) AS total_revenue,
RANK() OVER (ORDER BY SUM(revenue) DESC) AS revenue_rank
FROM sales_data
GROUP BY product;

--10:Quốc gia có profit cao hơn trung bình
SELECT country,SUM(profit) AS total_profit
FROM sales_data
GROUP BY country
HAVING SUM(profit) >
(
    SELECT AVG(total_profit)
    FROM (
        SELECT SUM(profit) AS total_profit
        FROM sales_data
        GROUP BY country
    ) t
);

--11:So sánh doanh thu mỗi năm với năm trước
SELECT year,SUM(revenue) AS total_revenue,
LAG(SUM(revenue)) OVER (ORDER BY year) AS prev_year_revenue
FROM sales_data
GROUP BY year
ORDER BY year;

--12:hiển thị tất cả giao dịch của 5 sản phẩm có doanh thu cao nhất
SELECT s.product, s.country, s.revenue, s.order_quantity
FROM sales_data s
INNER JOIN (
    SELECT product
    FROM sales_data
    GROUP BY product
    ORDER BY SUM(revenue) DESC
    LIMIT 5
) top_products
ON s.product = top_products.product;

--13:Tổng hợp thông tin sales_data
SELECT year, month, country, product_category,SUM(revenue) AS total_revenue,SUM(profit) AS total_profit,SUM(order_quantity) AS total_quantity
FROM sales_data
GROUP BY year, month, country, product_category;

--14:tổng doanh thu
SELECT SUM(revenue) FROM sales_data;

--15:tổng lợi nhuận
SELECT SUM(profit) FROM sales_data;
