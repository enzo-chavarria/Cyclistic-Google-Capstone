--Compare avg, med, max, and total number of rides between casual riders and members
SELECT
  member_casual,
  ROUND(AVG(ride_length), 2) AS avg_ride_length_minutes,
  APPROX_QUANTILES(ride_length, 100)[OFFSET(50)] AS median_ride_length_minutes,
  MAX(ride_length) AS max_ride_length_minutes,
  COUNT(*) AS num_rides
FROM `CyclisticData.trips_combined`
GROUP BY member_casual;
