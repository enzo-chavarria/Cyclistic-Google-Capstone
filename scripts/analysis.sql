--Compare avg, med, max, and total number of rides between casual riders and members
SELECT
  member_casual,
  ROUND(AVG(ride_length), 2) AS avg_ride_length_minutes,
  APPROX_QUANTILES(ride_length, 100)[OFFSET(50)] AS median_ride_length_minutes,
  MAX(ride_length) AS max_ride_length_minutes,
  COUNT(*) AS num_rides
FROM `CyclisticData.trips_combined`
GROUP BY member_casual;

--Compare Ride Count by Day of Week and Rider Type
SELECT
  member_casual,
  day_of_week,
  CASE day_of_week
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END AS day_name,
  COUNT(*) AS num_rides
FROM `CyclisticData.trips_combined`
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;
