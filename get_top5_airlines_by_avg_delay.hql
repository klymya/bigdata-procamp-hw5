CREATE TABLE IF NOT EXISTS ${SCHEMA}.avg_delay_result (
	IATA_CODE string,
	AVG_DELAY float
)
STORED AS ORC;

INSERT INTO TABLE ${SCHEMA}.avg_delay_result SELECT AIRLINE AS IATA_CODE, AVG(DEPARTURE_DELAY) as AVG_DELAY
FROM ${SCHEMA}.flights
GROUP BY AIRLINE
ORDER BY AVG_DELAY
DESC LIMIT 5;