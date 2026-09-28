CREATE TABLE testing_table (
  name VARCHAR(20),
  contact_name VARCHAR(20),
  roll_no VARCHAR(20)
);

ALTER TABLE testing_table
  DROP COLUMN name,
  ADD COLUMN first_name VARCHAR(20),
  ADD COLUMN last_name VARCHAR(20),
  ALTER COLUMN roll_no TYPE INTEGER
  Using roll_no::INTEGER; 

ALTER TABLE testing_table
  RENAME COLUMN contact_name TO user_name;
