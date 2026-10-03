--PROPERTIES BY CITY
SELECT
    city,
    COUNT(*) AS property_count
FROM real_estate
GROUP BY city
ORDER BY property_count DESC;

--AVG PRICE BY CITY
SELECT
CITY, ROUND(AVG(PRICE_INR_LAKHS), 2)AS AVG_PRICE_LAKHS
FROM REAL_ESTATE
GROUP BY CITY
ORDER BY AVG_PRICE_LAKHS DESC;

--AVG SQFT BY CITY
SELECT
    city,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM real_estate
GROUP BY city
ORDER BY avg_price_per_sqft DESC;

--Top 10 Locations by Average Price
SELECT
    locality,
    city,
    COUNT(*) AS property_count,
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs
FROM real_estate
WHERE locality <> 'Unknown'
GROUP BY locality, city
HAVING COUNT(*) >= 100
ORDER BY avg_price_lakhs DESC
LIMIT 10;

--Location Ranking by Average Price per Sq.Ft.
SELECT
    locality,
    city,
    COUNT(*) AS property_count,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft,
    RANK() OVER (
        ORDER BY AVG(price_per_sqft) DESC
    ) AS location_rank
FROM real_estate
WHERE locality <> 'Unknown'
GROUP BY locality, city
HAVING COUNT(*) >= 100
ORDER BY location_rank;
