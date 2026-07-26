-- 1. Combine twelve tables into one using a wildacard query
CREATE TABLE `CyclisticData.trips_combined` AS
SELECT *, _TABLE_SUFFIX AS source_table
FROM `CyclisticData.20*`

-- 2. Check that tables were combined correctly by comparing the summed row count of the twelve tables against the row count of the combined table
  
--Total row count of twelve tables
SELECT SUM(row_count) AS total_source_rows
FROM `CyclisticData.__TABLES__`
WHERE table_id != 'trips_combined';

--Total row count of combined table
SELECT COUNT(*) AS combined_row_count
FROM `CyclisticData.trips_combined`;
