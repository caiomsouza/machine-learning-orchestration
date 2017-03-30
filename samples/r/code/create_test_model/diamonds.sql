

-- DROP DATABASE data_science_demo_db;

CREATE DATABASE data_science_demo_db
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'English_United States.1252'
       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;


	   

CREATE TABLE diamonds_test
(
  carat DOUBLE PRECISION
, cut TEXT
, color TEXT
, clarity TEXT
, "depth" DOUBLE PRECISION
, "table" DOUBLE PRECISION
, price DOUBLE PRECISION
, x DOUBLE PRECISION
, y DOUBLE PRECISION
, z DOUBLE PRECISION
, logprice DOUBLE PRECISION
, logcarat DOUBLE PRECISION
, predicted_logprice DOUBLE PRECISION
)
;


