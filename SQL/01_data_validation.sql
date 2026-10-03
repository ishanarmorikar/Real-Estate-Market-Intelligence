CREATE TABLE real_estate (
    Property_ID VARCHAR(20) PRIMARY KEY,
    City VARCHAR(50),
    Locality VARCHAR(100),
    Locality_Type VARCHAR(30),
    Property_Type VARCHAR(50),
    BHK INTEGER,
    Bathrooms NUMERIC,
    Area_SqFt NUMERIC,
    Price_INR_Lakhs NUMERIC,
    Price_Per_SqFt NUMERIC,
    Property_Age_Years INTEGER,
    Furnishing_Status VARCHAR(30),
    Parking_Spaces INTEGER,
    Floor_Number INTEGER,
    Total_Floors INTEGER,
    Lift_Available INTEGER,
    Gated_Community INTEGER,
    Distance_to_Metro_km NUMERIC,
    Distance_to_City_Center_km NUMERIC,
    Transaction_Type VARCHAR(30),
    Amenities_Count INTEGER,
    Listing_Year INTEGER
);

SELECT COUNT(*) AS total_records
FROM real_estate;

SELECT * FROM real_estate
LIMIT 10;

SELECT COUNT(*) AS TOTAL_RECORDS,
COUNT(DISTINCT PROPERTY_ID) AS UNIQUE_PROPERTIES,
COUNT(*) - COUNT(DISTINCT PROPERTY_ID) AS DUPLICATE_IDS
FROM REAL_ESTATE;

SELECT
COUNT(*) FILTER (WHERE LOCALITY IS NULL) AS MISSING_LOCALITY,
COUNT(*) FILTER (WHERE FURNISHING_STATUS IS NULL) AS MISSING_FURNISHING,
COUNT(*) FILTER (WHERE PARKING_SPACES IS NULL)AS MISSING_PARKING,
COUNT(*) FILTER (WHERE BATHROOMS IS NULL) AS MISSING_BATHROOMS
FROM REAL_ESTATE;
