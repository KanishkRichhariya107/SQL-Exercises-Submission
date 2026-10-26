\c vtapp

\dt

--            List of tables
--  Schema | Name  | Type  |   Owner    
-- --------+-------+-------+------------
--  public | devs  | table | vtapp_user
--  public | users | table | postgres
-- (2 rows)

CREATE DATABASE restored;

\q

pg_dump -U postgres vtapp > backup.sql

psql -U postgres restored < backup.sql

psql -U postgres

\c restored

\dt
--            List of tables
--  Schema | Name  | Type  |   Owner    
-- --------+-------+-------+------------
--  public | devs  | table | vtapp_user
--  public | users | table | postgres
-- (2 rows)
