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

 
SELECT payee, SUM(amount) AS total FROM transactions GROUP BY payee 

INSERT INTO account (username, current_balance) 
VALUES ('schliemann',0);

INSERT INTO income (account_id, date_trans, amount,category)
VALUES
(1,'22-01-03',5000,'Tobias Gehalt');

INSERT INTO transactions
(account_id, payee, date_trans, amount, group_name, category, description )
VALUES
 (1,null,'2022-01-03',50,'living','cash',null),
 (1,'REWE','2022-01-03',38.54,'living','food',null),
 (1,'REWE','2022-01-03',90.04,'living','food',null),
 (1,'HUK','2022-01-03',851.62,'year_payment','insurance','car'),
 (1,'Felix Riehn','2022-01-03',1370,'living','housing','rent'),
 (1,'Amazon','2022-01-04',69,'year_payment','amazon_prime','membership'),
 (1,'REWE','2022-01-04',67.26,'living','food',null),
 (1,'Only','2022-01-04',19.99,'living','personal_spending','daniela_clothes'),
 (1,'HandM','2022-01-05',40.10,'living','personal_spending','tobias_clothes'),
 (1,'Sky','2022-01-05',33.34,'living','utilities','TV'),
 (1,'Kita','2022-01-06',178,'living','kita','Lukas'),
 (1,'1and1','2022-01-07',30.19,'living','utilities','Internet'),
 (1,'DAZN','2022-01-05',14.99,'living','utilities','TV');
