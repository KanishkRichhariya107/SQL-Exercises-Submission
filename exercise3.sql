CREATE DATABASE vtapp;

CREATE ROLE vtapp_user
LOGIN
PASSWORD 'ABC123';

GRANT CONNECT
ON DATABASE vtapp
TO vtapp_user;

\c vtapp postgres;

GRANT USAGE, CREATE
ON SCHEMA public
TO vtapp_user;

GRANT ALL Privileges ON all tables IN schema public TO vtapp_user;

\c vtapp vtapp_user;

CREATE TABLE users(
    id Integer
    );