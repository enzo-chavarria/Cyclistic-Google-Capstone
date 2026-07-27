--Check for duplicate ride id’s
SELECT ride_id, COUNT(*) AS occurrences
FROM `CyclisticData.trips_combined`
GROUP BY ride_id
HAVING COUNT(*) > 1;

--Return all the duplicated rows in full
SELECT *
FROM `CyclisticData.trips_combined`
WHERE ride_id IN (
  SELECT ride_id
  FROM `CyclisticData.trips_combined`
  GROUP BY ride_id
 HAVING COUNT(*) > 1
)
ORDER BY ride_id;

--Remove duplicates, keeping the rides with source table 26-04-Trips
DELETE FROM `CyclisticData.trips_combined`
WHERE source_table = '26-05-Trips'
  AND ride_id IN (
    SELECT ride_id
    FROM `CyclisticData.trips_combined`
    GROUP BY ride_id
    HAVING COUNT(*) > 1
  );

--Check for null values
SELECT
  COUNTIF(ride_id IS NULL) AS null_ride_id,
  COUNTIF(rideable_type IS NULL) AS null_rideable_type,
  COUNTIF(started_at IS NULL) AS null_started_at,
  COUNTIF(ended_at IS NULL) AS null_ended_at,
  COUNTIF(start_station_name IS NULL) AS null_start_station_name,
  COUNTIF(start_station_id IS NULL) AS null_start_station_id,
  COUNTIF(end_station_name IS NULL) AS null_end_station_name,
  COUNTIF(end_station_id IS NULL) AS null_end_station_id,
  COUNTIF(start_lat IS NULL) AS null_start_lat,
  COUNTIF(start_lng IS NULL) AS null_start_lng,
  COUNTIF(end_lat IS NULL) AS null_end_lat,
  COUNTIF(end_lng IS NULL) AS null_end_lng,
  COUNTIF(member_casual IS NULL) AS null_member_casual,
  COUNTIF(source_table IS NULL) AS null_source_table
FROM `CyclisticData.trips_combined`;

--Investigate null values for rideable type
SELECT
  rideable_type,
  COUNTIF(start_station_name IS NULL) AS null_start_station,
  COUNT(*) AS total_rides
FROM `CyclisticData.trips_combined`
GROUP BY rideable_type;

--Add ride length and day of week columns
CREATE OR REPLACE TABLE `CyclisticData.trips_combined` AS
SELECT
  *,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
FROM `CyclisticData.trips_combined`;

--Check for negative or null ride lengths
SELECT COUNTIF(ride_length < 0) AS negative_ride_length,
       COUNTIF(ride_length IS NULL) AS null_ride_length
FROM `CyclisticData.trips_combined`;

--Inspect negative ride length rows
SELECT ride_id, started_at, ended_at, ride_length, rideable_type, member_casual
FROM `CyclisticData.trips_combined`
WHERE ride_length < 0
ORDER BY ride_length;

--Add 60 to the negative ride lengths to correct for daylight savings
UPDATE `CyclisticData.trips_combined`
SET ride_length = ride_length + 60
WHERE ride_length < 0
  AND DATE(started_at) = '2025-11-02'
  AND EXTRACT(HOUR FROM started_at) = 1;

--Count how many rides exceed 24 hours
SELECT COUNT(*) AS rides_over_24_hours
FROM `CyclisticData.trips_combined`
WHERE ride_length > 1440;

--Remove all rows with ride lengths greater than 24 hours
DELETE FROM `CyclisticData.trips_combined`
WHERE ride_length > 1440;

--Count how many rides have lengths less than one minute
SELECT COUNT(*) AS very_short_rides
FROM `CyclisticData.trips_combined`
WHERE ride_length < 1;

--Delete rows that have ride lengths less than one minute
DELETE FROM `CyclisticData.trips_combined`
WHERE ride_length < 1;

--Check if any coords lie outside Chicago
SELECT COUNT(*) AS out_of_range
FROM `CyclisticData.trips_combined`
WHERE start_lat NOT BETWEEN 41.4 AND 42.3
   OR start_lng NOT BETWEEN -88.5 AND -87.3;

  

