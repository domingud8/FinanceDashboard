
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


INSERT INTO transactions ( account_id,amount,category,payee,date_trans) VALUES
(1,1150,'housing','RENT','2021-01-03'),
(1,1150,'housing','RENT','2021-02-03'),
(1,1150,'housing','RENT','2021-03-03'),
(1,1150,'housing','RENT','2021-04-03'),
(1,1150,'housing','RENT','2021-05-03'),
(1,1150,'housing','RENT','2021-06-03'),
(1,1150,'housing','RENT','2021-07-03'),
(1,1150,'housing','RENT','2021-08-03'),
(1,1150,'housing','RENT','2021-09-03'),
(1,1150,'housing','RENT','2021-10-03'),
(1,1150,'housing','RENT','2021-11-03'),
(1,1150,'housing','RENT','2021-12-03'),
(1,17.50,'utilities','TV','2021-01-15'),
(1,17.50,'utilities','TV','2021-02-15'),
(1,17.50,'utilities','TV','2021-03-15'),
(1,17.50,'utilities','TV','2021-04-15'),
(1,17.50,'utilities','TV','2021-05-15'),
(1,17.50,'utilities','TV','2021-06-15'),
(1,17.50,'utilities','TV','2021-07-15'),
(1,17.50,'utilities','TV','2021-08-15'),
(1,17.50,'utilities','TV','2021-09-15'),
(1,17.50,'utilities','TV','2021-10-15'),
(1,17.50,'utilities','TV','2021-11-15'),
(1,17.50,'utilities','TV','2021-12-15'),
(1,35,'utilities','Sky','2021-01-10'),
(1,35,'utilities','Sky','2021-02-10'),
(1,35,'utilities','Sky','2021-03-10'),
(1,35,'utilities','Sky','2021-04-10'),
(1,35,'utilities','Sky','2021-05-10'),
(1,35,'utilities','Sky','2021-06-10'),
(1,35,'utilities','Sky','2021-07-10'),
(1,35,'utilities','Sky','2021-08-10'),
(1,35,'utilities','Sky','2021-09-10'),
(1,35,'utilities','Sky','2021-10-10'),
(1,35,'utilities','Sky','2021-11-10'),
(1,35,'utilities','Sky','2021-12-10'),
(1,25.5,'utilities','Water','2021-01-12'),
(1,25.5,'utilities','Water','2021-02-12'),
(1,25.5,'utilities','Water','2021-03-12'),
(1,25.5,'utilities','Water','2021-04-12'),
(1,25.5,'utilities','Water','2021-05-12'),
(1,25.5,'utilities','Water','2021-06-12'),
(1,25.5,'utilities','Water','2021-07-12'),
(1,25.5,'utilities','Water','2021-08-12'),
(1,25.5,'utilities','Water','2021-09-12'),
(1,25.5,'utilities','Water','2021-10-12'),
(1,25.5,'utilities','Water','2021-11-12'),
(1,25.5,'utilities','Water','2021-12-12'),
(1,85,'utilities','Water','2021-01-01'),
(1,85,'utilities','Water','2021-02-02'),
(1,85,'utilities','Water','2021-03-03'),
(1,85,'utilities','Water','2021-04-04'),
(1,85,'utilities','Water','2021-05-05'),
(1,90,'utilities','Water','2021-06-05'),
(1,90,'utilities','Water','2021-07-05'),
(1,90,'utilities','Water','2021-08-05'),
(1,100,'utilities','Water','2021-09-05'),
(1,100,'utilities','Water','2021-10-05'),
(1,100,'utilities','Water','2021-11-05'),
(1,100,'utilities','Water','2021-12-05');






INSERT INTO income ( account_id,date_trans,amount,category) VALUES
(1,'2021-01-02', 3200, 'salary'),
(1,'2021-02-02', 3200, 'salary'),
(1,'2021-03-02', 3200, 'salary'),
(1,'2021-04-02', 3200, 'salary'),
(1,'2021-05-02', 3200, 'salary'),
(1,'2021-06-02', 3200, 'salary'),
(1,'2021-07-02', 3200, 'salary'),
(1,'2021-08-02', 3200, 'salary'),
(1,'2021-09-02', 3200, 'salary'),
(1,'2021-10-02', 3200, 'salary'),
(1,'2021-11-02', 3200, 'salary'),
(1,'2021-12-02', 3200, 'salary');