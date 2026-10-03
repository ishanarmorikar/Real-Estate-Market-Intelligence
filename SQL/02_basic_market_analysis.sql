--TOTAL PROPERTIES
SELECT COUNT(*) AS total_properties
FROM real_estate;

--AVG PROPERTY PRICE
SELECT 
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs
FROM real_estate;

--MEDIAN PROPERTY PRICE
SELECT 
    ROUND(
        PERCENTILE_CONT(0.5) 
        WITHIN GROUP (ORDER BY price_inr_lakhs)::numeric,
        2
    ) AS median_price_lakhs
FROM real_estate;

--AVG PRICE PER SQ.FT
SELECT ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_SQFT
FROM REAL_ESTATE;

--AVG PROPERTY AREA
SELECT ROUND(AVG(AREA_SQFT), 2) AS AVG_AREA_SQFT
FROM REAL_ESTATE;