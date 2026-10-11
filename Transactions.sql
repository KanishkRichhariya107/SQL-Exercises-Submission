CREATE DATABASE bank;

\c bank;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL,
    account_no VARCHAR(20) UNIQUE NOT NULL
);
CREATE TABLE accounts(
    id SERIAL PRIMARY KEY,
    account_no VARCHAR(20) UNIQUE NOT NULL,
    balance INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (account_no) REFERENCES users(account_no)
);
INSERT INTO users (name, email, account_no)
VALUES
    ('UserA', 'usera@example.com', 'ACC101'),
    ('UserB', 'userb@example.com', 'ACC102');

INSERT INTO accounts (account_no, balance)
VALUES
    ('ACC101', 5000),
    ('ACC102', 3000);

BEGIN;

UPDATE accounts
SET balance = balance + 1000
WHERE account_no = (
    SELECT account_no
    FROM users
    WHERE name = 'UserA'
);

COMMIT;

BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE account_no = (
    SELECT account_no
    FROM users
    WHERE name = 'UserA'
);

COMMIT;


BEGIN;

UPDATE accounts
SET balance = balance - 200
WHERE account_no = (
    SELECT account_no
    FROM users
    WHERE name = 'UserA'
);


UPDATE accounts
SET balance = balance + 200
WHERE account_no = (
    SELECT account_no
    FROM users
    WHERE name = 'UserB'
);

COMMIT;