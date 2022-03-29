
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
    date_trans   DATE NOT NULL,
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



INSERT INTO transactions ( 
    account_id,
	amount,
	category,
	date_trans
) SELECT 
  1,
  ROUND((random()*100)::numeric , 2 ), -- for integer
  (ARRAY['housing','transportation','food','utilities','insurance','medical','personal spending','hobbies'])[round(7*random())+1], -- for char/enum
  DATE(timestamp '2021-01-01 20:00:00' +
       random() * (timestamp '2021-01-30 20:00:00' -
                   timestamp '2021-01-01 10:00:00'))
FROM generate_series(1,100);


