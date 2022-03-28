
DROP TABLE IF EXISTS income;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS account;

CREATE TABLE account(
    id SERIAL PRIMARY KEY,
    username VARCHAR NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR NOT NULL,
    current_balance NUMERIC(10,5) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    categories ARRAY 
);


CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL REFERENCES account (id),
    payee  VARCHAR ,
    date   DATE NOT NULL,
    amount NUMERIC NOT NULL,
    group VARCHAR,
    category VARCHAR,
    description VARCHAR  
);

CREATE TABLE income (
    id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL REFERENCES account (id),
    date_trans   DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    category  VARCHAR
);
