# bigdata-procamp-hw5
bigdata procamp hw #5 "Hadoop Hive Lab"

## 1

The repo consists of `hql` files with hive queries and `sh` scripts that run these query files. Because hive does not support multiline queries.

To load samle data into hive:

- run `./load_flights_data.sh`

To find top 5 airlines with the greatest average DEPARTURE_DELAY:

- run `./get_top5_airlines_by_avg_delay.sh`

Check out bash scripts parameters with `-h` flag or open the files

## 2

To test the script need to create a testing database that will contain dummy data. This could be done by run `load_flights_data.sh` and `get_top5_airlines_by_avg_delay.sh` with testing input parameters.