--AVG PRICE BY BHK
SELECT
    bhk,
    COUNT(*) AS property_count,
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM real_estate
GROUP BY bhk
ORDER BY bhk;

--PROPERTY TYPE ANALYSIS
SELECT
    property_type,
    COUNT(*) AS property_count,
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM real_estate
GROUP BY property_type
ORDER BY property_count DESC;

--FURNISHING STATUS ANALYSIS
SELECT FURNISHING_STATUS,
COUNT(*)AS PROPERTY_COUNT,
ROUND(AVG(PRICE_INR_LAKHS), 2)AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_PER_SQFT
FROM REAL_ESTATE
GROUP BY FURNISHING_STATUS
ORDER BY AVG_PRICE_LAKHS DESC;


UPDATE REAL_ESTATE
SET FURNISHING_STATUS = 'Semi-Furnished'
WHERE LOWER(TRIM(furnishing_status)) = 'semi-furnished';

SELECT
    furnishing_status,
    COUNT(*) AS property_count
FROM real_estate
GROUP BY furnishing_status
ORDER BY furnishing_status;

UPDATE real_estate
SET locality_type = 'Mid-Range'
WHERE LOWER(TRIM(locality_type)) = 'mid-range';

SELECT
    locality_type,
    COUNT(*) AS property_count
FROM real_estate
GROUP BY locality_type
ORDER BY locality_type;

UPDATE real_estate
SET locality = 'Unknown'
WHERE locality IS NULL OR TRIM(locality) = '';

UPDATE real_estate
SET furnishing_status = 'Not Specified'
WHERE furnishing_status IS NULL OR TRIM(furnishing_status) = '';

UPDATE real_estate
SET parking_spaces = 0
WHERE parking_spaces IS NULL;

SELECT
    COUNT(*) AS total_records,
    
    COUNT(DISTINCT property_id) AS unique_property_ids,
    
    COUNT(*) - COUNT(DISTINCT property_id) AS duplicate_property_ids,
    
    COUNT(*) FILTER (
        WHERE locality IS NULL OR TRIM(locality) = ''
    ) AS missing_locality,
    
    COUNT(*) FILTER (
        WHERE furnishing_status IS NULL 
           OR TRIM(furnishing_status) = ''
    ) AS missing_furnishing_status,
    
    COUNT(*) FILTER (
        WHERE parking_spaces IS NULL
    ) AS missing_parking,
    
    COUNT(*) FILTER (
        WHERE bathrooms IS NULL
    ) AS missing_bathrooms

FROM real_estate;

SELECT
    furnishing_status,
    COUNT(*) AS count
FROM real_estate
GROUP BY furnishing_status
ORDER BY furnishing_status;

--FURNISHING STATUS ANALYSIS
SELECT FURNISHING_STATUS,
COUNT(*)AS PROPERTY_COUNT,
ROUND(AVG(PRICE_INR_LAKHS), 2)AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_PER_SQFT
FROM REAL_ESTATE
GROUP BY FURNISHING_STATUS
ORDER BY AVG_PRICE_LAKHS DESC;


--AREA AND PRICE ANALYSIS BY BHK
SELECT BHK,
COUNT(*) AS PROPERRTY_COUNT,
ROUND(AVG(AREA_SQFT), 2)AS AVG_AREA_SQFT,
ROUND(AVG(PRICE_INR_LAKHS), 2) AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2) AS AVG_PRICE_PER_SQFT
FROM REAL_ESTATE
GROUP BY BHK
ORDER BY BHK;

--PARKING ANALYSIS
SELECT PARKING_SPACES,
COUNT(*) AS PROPERTY_COUNT,
ROUND(AVG(PRICE_INR_LAKHS), 2)AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_PER_SQFT
FROM REAL_ESTATE
GROUP BY PARKING_SPACES
ORDER BY PARKING_SPACES;

-- Property Age Analysis
SELECT
    property_age_group,
    COUNT(*) AS property_count,
    ROUND(AVG(price_inr_lakhs), 2) AS avg_price_lakhs,
    ROUND(AVG(price_per_sqft), 2) AS avg_price_per_sqft
FROM (
    SELECT
        CASE
            WHEN property_age_years <= 5 THEN '0-5 Years'
            WHEN property_age_years <= 10 THEN '6-10 Years'
            WHEN property_age_years <= 20 THEN '11-20 Years'
            ELSE '20+ Years'
        END AS property_age_group,
        price_inr_lakhs,
        price_per_sqft
    FROM real_estate
) AS property_data
GROUP BY property_age_group
ORDER BY
    CASE property_age_group
        WHEN '0-5 Years' THEN 1
        WHEN '6-10 Years' THEN 2
        WHEN '11-20 Years' THEN 3
        WHEN '20+ Years' THEN 4
    END;

--amenties analysis
SELECT AMENITIES_COUNT,
COUNT(*)AS PROPERTY_COUNT,
ROUND(AVG(PRICE_INR_LAKHS), 2) AS AVG_PRICE_LAKHS,
ROUND(AVG(PRICE_PER_SQFT), 2)AS AVG_PRICE_PER_SQFT
FROM REAL_ESTATE
GROUP BY AMENITIES_COUNT
ORDER BY AMENITIES_COUNT;


--BHK DISTRIBUTION BY CITY
SELECT CITY, BHK, COUNT(*)AS PROPERTY_COUNT
FROM REAL_ESTATE
GROUP BY CITY, BHK 
ORDER BY CITY, BHK;


--PROPERTY TYPE DISTRIBUTION BY CITY
SELECT CITY, PROPERTY_TYPE,
COUNT(*)AS PROPERTY_COUNT
FROM REAL_ESTATE
GROUP BY CITY, PROPERTY_TYPE
ORDER BY CITY, PROPERTY_TYPE DESC;


--Top 10 Most Expensive Properties
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
ORDER BY price_inr_lakhs DESC
LIMIT 10;
