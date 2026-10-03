--Rank Locations by Average Property Price
SELECT
    locality,
    city,
    COUNT(*) AS property_count,
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs,
    RANK() OVER (
        ORDER BY AVG(price_inr_lakhs) DESC
    ) AS price_rank
FROM real_estate
WHERE locality <> 'Unknown'
GROUP BY locality, city
HAVING COUNT(*) >= 100
ORDER BY price_rank;

-- CITYWISE PRICE RANKING
SELECT CITY, COUNT(*) AS PROPERTY_COUNT,
ROUND(AVG(PRICE_INR_LAKHS), 2)AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_PER_SQFT,
RANK() OVER(
	ORDER BY AVG(PRICE_INR_LAKHS) DESC
)AS CITY_PRICE_RANK
FROM REAL_ESTATE
GROUP BY CITY
ORDER BY CITY_PRICE_RANK;

--TOP 3 PROPERTIES IN EACH CITY
WITH RANKED_PROPERTIES AS(
	SELECT PROPERTY_ID, CITY, LOCALITY, PROPERTY_TYPE, BHK, AREA_SQFT, PRICE_INR_LAKHS, PRICE_PER_SQFT,
	ROW_NUMBER() OVER (
		PARTITION BY CITY
		ORDER BY PRICE_INR_LAKHS DESC
	)AS PROPERTY_RANK
	FROM REAL_ESTATE
)
SELECT
PROPERTY_ID, CITY, LOCALITY, PROPERTY_TYPE, BHK, AREA_SQFT,
ROUND(PRICE_INR_LAKHS, 2)AS PRICE_LAKHS,
ROUND(PRICE_PER_SQFT, 2)AS PRICE_PER_SQFT,
PROPERTY_RANK
FROM RANKED_PROPERTIES
WHERE PROPERTY_RANK <= 3
ORDER BY CITY, PROPERTY_RANK;


--PROPERTY PRICE SEGMENTATION
SELECT
    price_segment,
    COUNT(*) AS property_count,
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM (
    SELECT
        CASE
            WHEN price_inr_lakhs < 100 THEN 'Budget'
            WHEN price_inr_lakhs < 300 THEN 'Mid-Range'
            ELSE 'Premium'
        END AS price_segment,
        price_inr_lakhs,
        price_per_sqft
    FROM real_estate
) AS segmented_data
GROUP BY price_segment
ORDER BY
    CASE price_segment
        WHEN 'Budget' THEN 1
        WHEN 'Mid-Range' THEN 2
        WHEN 'Premium' THEN 3
    END;


--BHK PRICE COMPARISON WITHIN EACH CITY
SELECT CITY, BHK, COUNT(*)AS PROPERTY_COUNT,
ROUND(AVG(PRICE_INR_LAKHS), 2)AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_PER_SQFT,
RANK() OVER(
	PARTITION BY CITY
	ORDER BY AVG(PRICE_INR_LAKHS) DESC
)AS BHK_PRICE_RANK
FROM REAL_ESTATE
GROUP BY CITY, BHK
ORDER BY CITY, BHK_PRICE_RANK;

--HIGH VALUE PROPERTY IDENTIFICATION
SELECT
    property_id,
    city,
    locality,
    property_type,
    bhk,
    area_sqft,
    ROUND(price_inr_lakhs, 2) AS price_lakhs,
    ROUND(price_per_sqft, 2) AS price_per_sqft
FROM real_estate
WHERE price_inr_lakhs > (
        SELECT AVG(price_inr_lakhs)
        FROM real_estate
    )
AND price_per_sqft > (
        SELECT AVG(price_per_sqft)
        FROM real_estate
    )
ORDER BY price_inr_lakhs DESC;
