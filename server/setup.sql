
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
    categories VARCHAR 
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


INSERT INTO account (username, email, password_hash, current_balance) VALUES ("family","family@example.com",'$2a$10$AyECxPouKJ89.Xx9qkE4XexUqSI0XT.dezYIc6BchsDoXeYpRd2Fq',0)

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




INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1797, 1, 'DINNER', '2021-05-12', 4.35, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1825, 1, 'DM', '2021-04-05', 56.99, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2343, 1, 'CINEMA', '2021-02-18', 9.01, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2344, 1, 'CINEMA', '2021-02-12', 45.51, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1937, 1, 'REWE', '2021-07-22', 74.70, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1938, 1, 'REWE', '2021-07-27', 72.85, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1967, 1, 'DEICHMANN', '2021-08-10', 22.64, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2002, 1, 'DM', '2021-09-26', 85.23, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2003, 1, 'DM', '2021-09-04', 51.02, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2048, 1, 'EDEKA', '2021-10-08', 33.95, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2049, 1, 'EDEKA', '2021-10-10', 62.61, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2080, 1, 'CINEMA', '2021-11-03', 56.48, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2081, 1, 'CINEMA', '2021-11-28', 11.95, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2109, 1, 'REWE', '2021-12-23', 27.68, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2110, 1, 'REWE', '2021-12-11', 99.70, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2111, 1, 'REWE', '2021-12-24', 81.12, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2345, 1, 'CINEMA', '2021-02-04', 56.65, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2346, 1, 'CINEMA', '2021-02-11', 38.98, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2285, 1, 'REWE', '2021-01-06', 17.35, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2287, 1, 'REWE', '2021-01-18', 21.01, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2288, 1, 'REWE', '2021-01-12', 72.17, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1798, 1, 'EDEKA', '2021-04-02', 33.51, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1826, 1, 'RYANAIR', '2021-05-16', 98.00, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1766, 1, 'CAR', '2021-03-11', 53.50, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1767, 1, 'CAR', '2021-03-02', 44.55, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1768, 1, 'CAR', '2021-03-11', 56.29, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2297, 1, 'HVV', '2021-01-08', 37.05, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2299, 1, 'HVV', '2021-01-15', 6.44, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1939, 1, 'ALDI', '2021-07-28', 55.59, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1940, 1, 'ALDI', '2021-07-12', 36.24, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1968, 1, 'ALDI', '2021-08-27', 96.34, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2004, 1, 'EDEKA', '2021-09-14', 23.19, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2005, 1, 'EDEKA', '2021-09-18', 5.52, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2050, 1, 'CAR', '2021-10-06', 85.77, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2052, 1, 'CAR', '2021-10-24', 90.59, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2082, 1, 'C&A', '2021-11-27', 20.63, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2083, 1, 'C&A', '2021-11-20', 19.42, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2347, 1, 'C&A', '2021-02-02', 99.18, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2348, 1, 'C&A', '2021-02-19', 11.27, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2349, 1, 'C&A', '2021-02-24', 49.50, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2350, 1, 'C&A', '2021-02-15', 44.11, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2298, 1, 'HVV', '2021-01-04', 39.20, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2300, 1, 'HVV', '2021-01-02', 64.83, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1799, 1, 'C&A', '2021-04-03', 89.04, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1827, 1, 'CINEMA', '2021-04-27', 52.65, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1769, 1, 'DINNER', '2021-03-19', 47.93, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1770, 1, 'DINNER', '2021-03-03', 7.11, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1771, 1, 'DINNER', '2021-03-06', 87.56, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2301, 1, 'DINNER', '2021-01-20', 13.40, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2302, 1, 'DINNER', '2021-01-26', 67.56, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1900, 1, 'REWE', '2021-06-10', 48.23, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1901, 1, 'REWE', '2021-06-10', 25.95, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1902, 1, 'REWE', '2021-06-28', 0.94, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1941, 1, 'ALDI', '2021-07-06', 0.42, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1942, 1, 'ALDI', '2021-07-24', 22.13, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1943, 1, 'ALDI', '2021-07-26', 49.45, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1944, 1, 'ALDI', '2021-07-05', 40.72, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1969, 1, 'EDEKA', '2021-08-13', 43.89, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2006, 1, 'DM', '2021-09-27', 82.54, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2007, 1, 'DM', '2021-09-05', 8.62, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2008, 1, 'DM', '2021-09-23', 88.45, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2051, 1, 'COFFEE', '2021-10-17', 59.13, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2053, 1, 'COFFEE', '2021-10-27', 94.12, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2084, 1, 'EDEKA', '2021-11-07', 34.80, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2085, 1, 'EDEKA', '2021-11-15', 73.05, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2303, 1, 'DINNER', '2021-01-16', 51.82, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2304, 1, 'DINNER', '2021-01-07', 11.41, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2351, 1, 'EDEKA', '2021-02-12', 99.13, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2155, 1, 'RYANAIR', '2021-12-07', 17.73, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2156, 1, 'RYANAIR', '2021-12-02', 24.59, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2352, 1, 'EDEKA', '2021-02-15', 86.95, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2353, 1, 'EDEKA', '2021-02-11', 11.90, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2354, 1, 'EDEKA', '2021-02-19', 52.29, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1800, 1, 'CAR', '2021-05-07', 58.04, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1828, 1, 'C&A', '2021-05-26', 83.70, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1772, 1, 'C&A', '2021-03-08', 48.62, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1773, 1, 'C&A', '2021-03-05', 62.43, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1774, 1, 'C&A', '2021-03-07', 50.03, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1903, 1, 'HVV', '2021-06-21', 99.66, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1904, 1, 'HVV', '2021-06-27', 56.81, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1905, 1, 'HVV', '2021-06-09', 18.98, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1945, 1, 'RYANAIR', '2021-07-12', 87.78, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1946, 1, 'RYANAIR', '2021-07-20', 71.06, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1947, 1, 'RYANAIR', '2021-07-02', 21.03, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1948, 1, 'RYANAIR', '2021-07-09', 79.42, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1970, 1, 'EDEKA', '2021-08-21', 21.39, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2009, 1, 'CAR', '2021-09-22', 10.55, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2010, 1, 'CAR', '2021-09-15', 43.04, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2011, 1, 'CAR', '2021-09-11', 52.20, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2054, 1, 'C&A', '2021-10-06', 14.24, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2055, 1, 'C&A', '2021-10-15', 14.96, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2086, 1, 'ALDI', '2021-11-03', 11.72, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2087, 1, 'ALDI', '2021-11-03', 31.15, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2157, 1, 'COFFEE', '2021-12-14', 12.63, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2158, 1, 'COFFEE', '2021-12-15', 10.79, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1801, 1, 'ALDI', '2021-04-06', 0.84, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1802, 1, 'ALDI', '2021-04-14', 71.11, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1803, 1, 'ALDI', '2021-05-06', 58.52, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1829, 1, 'REWE', '2021-04-21', 12.26, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1830, 1, 'REWE', '2021-05-07', 3.14, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2309, 1, 'REWE', '2021-01-08', 84.54, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2310, 1, 'REWE', '2021-01-21', 39.33, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1906, 1, 'DINNER', '2021-06-03', 91.61, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1907, 1, 'DINNER', '2021-06-18', 39.52, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1908, 1, 'DINNER', '2021-06-21', 77.30, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1949, 1, 'DINNER', '2021-07-26', 86.09, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1950, 1, 'DINNER', '2021-07-15', 46.64, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1951, 1, 'DINNER', '2021-07-14', 33.85, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1952, 1, 'DINNER', '2021-07-04', 93.92, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1971, 1, 'REWE', '2021-08-23', 51.17, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1972, 1, 'REWE', '2021-08-09', 38.52, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1973, 1, 'REWE', '2021-08-18', 8.75, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2012, 1, 'DINNER', '2021-09-12', 4.37, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2013, 1, 'DINNER', '2021-09-18', 14.83, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2014, 1, 'DINNER', '2021-09-04', 59.45, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2056, 1, 'ALDI', '2021-10-28', 91.66, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2057, 1, 'ALDI', '2021-10-14', 99.12, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2088, 1, 'EDEKA', '2021-11-26', 99.33, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2089, 1, 'EDEKA', '2021-11-11', 52.62, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2120, 1, 'RYANAIR', '2021-12-27', 9.17, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2121, 1, 'RYANAIR', '2021-12-23', 6.20, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2159, 1, 'DEICHMANN', '2021-12-22', 45.64, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2160, 1, 'DEICHMANN', '2021-12-22', 45.45, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2311, 1, 'REWE', '2021-01-10', 79.43, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2312, 1, 'REWE', '2021-01-06', 8.14, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1804, 1, 'RYANAIR', '2021-05-20', 61.67, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1805, 1, 'RYANAIR', '2021-05-21', 12.19, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1776, 1, 'HVV', '2021-03-13', 47.01, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1806, 1, 'RYANAIR', '2021-04-08', 86.90, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1833, 1, 'DM', '2021-04-08', 68.07, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2363, 1, 'DM', '2021-02-06', 2.04, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1909, 1, 'DEICHMANN', '2021-06-11', 43.28, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1910, 1, 'DEICHMANN', '2021-06-23', 12.67, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1911, 1, 'DEICHMANN', '2021-06-19', 42.26, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1953, 1, 'C&A', '2021-07-09', 33.66, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1954, 1, 'C&A', '2021-07-18', 91.86, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1955, 1, 'C&A', '2021-07-17', 52.72, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1956, 1, 'C&A', '2021-07-10', 60.05, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1974, 1, 'RYANAIR', '2021-08-07', 79.83, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1975, 1, 'RYANAIR', '2021-08-20', 30.51, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1976, 1, 'RYANAIR', '2021-08-12', 78.25, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2015, 1, 'DEICHMANN', '2021-09-13', 93.45, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2016, 1, 'DEICHMANN', '2021-09-05', 61.71, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2017, 1, 'DEICHMANN', '2021-09-20', 23.98, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2058, 1, 'REWE', '2021-10-21', 35.11, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2059, 1, 'REWE', '2021-10-03', 23.27, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2090, 1, 'EDEKA', '2021-11-04', 14.14, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2122, 1, 'CINEMA', '2021-12-21', 15.10, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2123, 1, 'CINEMA', '2021-12-11', 26.50, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2259, 1, 'CAR', '2021-01-14', 39.95, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1807, 1, 'COFFEE', '2021-05-20', 0.82, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1808, 1, 'COFFEE', '2021-04-21', 61.88, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1777, 1, 'DINNER', '2021-03-12', 31.21, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1809, 1, 'COFFEE', '2021-04-22', 32.08, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2317, 1, 'EDEKA', '2021-01-28', 2.68, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2318, 1, 'EDEKA', '2021-01-29', 5.28, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2319, 1, 'EDEKA', '2021-01-02', 53.54, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2320, 1, 'EDEKA', '2021-01-06', 39.46, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1912, 1, 'DM', '2021-06-23', 53.30, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1913, 1, 'DM', '2021-06-22', 65.89, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1914, 1, 'DM', '2021-06-15', 46.71, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1957, 1, 'EDEKA', '2021-08-10', 92.31, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1977, 1, 'DINNER', '2021-08-01', 95.42, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1978, 1, 'DINNER', '2021-08-27', 38.72, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1979, 1, 'DINNER', '2021-08-05', 82.56, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2018, 1, 'REWE', '2021-09-06', 33.69, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2019, 1, 'REWE', '2021-09-02', 37.13, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2020, 1, 'REWE', '2021-09-11', 83.39, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2060, 1, 'DM', '2021-10-12', 63.75, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2061, 1, 'DM', '2021-10-12', 26.80, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2091, 1, 'HVV', '2021-11-28', 57.62, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2124, 1, 'DEICHMANN', '2021-12-19', 12.86, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2125, 1, 'DEICHMANN', '2021-12-20', 80.12, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2163, 1, 'EDEKA', '2021-12-14', 42.78, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2164, 1, 'EDEKA', '2021-12-07', 39.31, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2364, 1, 'RYANAIR', '2021-02-22', 91.32, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2260, 1, 'DINNER', '2021-01-14', 28.45, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1810, 1, 'C&A', '2021-04-12', 96.66, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1811, 1, 'C&A', '2021-04-11', 27.01, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1778, 1, 'DEICHMANN', '2021-03-22', 99.28, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1812, 1, 'C&A', '2021-05-03', 89.39, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1835, 1, 'REWE', '2021-04-10', 73.69, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1836, 1, 'REWE', '2021-05-16', 22.97, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2321, 1, 'REWE', '2021-02-19', 28.12, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2322, 1, 'REWE', '2021-02-05', 13.58, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2365, 1, 'DINNER', '2021-02-23', 59.87, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1915, 1, 'DM', '2021-06-28', 57.39, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1916, 1, 'DM', '2021-06-18', 54.21, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1917, 1, 'DM', '2021-06-25', 99.39, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1958, 1, 'DINNER', '2021-08-08', 29.58, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1980, 1, 'DM', '2021-08-05', 43.54, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1982, 1, 'DM', '2021-08-14', 16.32, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1983, 1, 'DM', '2021-08-08', 48.39, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2021, 1, 'REWE', '2021-09-10', 5.43, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2022, 1, 'REWE', '2021-09-09', 27.25, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2023, 1, 'REWE', '2021-09-03', 20.06, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2062, 1, 'EDEKA', '2021-11-28', 1.47, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2063, 1, 'EDEKA', '2021-11-06', 98.14, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2092, 1, 'CINEMA', '2021-11-26', 37.35, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2165, 1, 'REWE', '2021-12-04', 4.27, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2166, 1, 'REWE', '2021-12-04', 33.07, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1813, 1, 'HVV', '2021-04-06', 40.66, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1814, 1, 'HVV', '2021-05-29', 36.79, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1779, 1, 'REWE', '2021-03-17', 1.81, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2323, 1, 'CAR', '2021-02-07', 85.75, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2324, 1, 'CAR', '2021-02-27', 9.86, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1918, 1, 'REWE', '2021-06-07', 67.90, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1919, 1, 'REWE', '2021-06-04', 61.63, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1920, 1, 'REWE', '2021-06-06', 84.04, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1959, 1, 'CAR', '2021-08-20', 48.77, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1981, 1, 'C&A', '2021-08-27', 86.52, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1984, 1, 'C&A', '2021-08-24', 54.61, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1985, 1, 'C&A', '2021-08-21', 78.45, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2024, 1, 'ALDI', '2021-09-27', 83.48, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2025, 1, 'ALDI', '2021-09-01', 49.14, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2026, 1, 'ALDI', '2021-09-12', 51.03, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2064, 1, 'RYANAIR', '2021-11-12', 16.54, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2065, 1, 'RYANAIR', '2021-11-16', 98.42, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2093, 1, 'DEICHMANN', '2021-11-13', 67.13, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2167, 1, 'REWE', '2021-12-10', 4.09, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2168, 1, 'REWE', '2021-12-06', 63.81, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2169, 1, 'REWE', '2021-12-15', 4.56, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2262, 1, 'REWE', '2021-01-11', 72.76, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1815, 1, 'DINNER', '2021-05-18', 84.59, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1816, 1, 'DINNER', '2021-04-28', 63.91, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1841, 1, 'EDEKA', '2021-05-26', 62.91, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1842, 1, 'EDEKA', '2021-05-10', 70.91, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1843, 1, 'EDEKA', '2021-05-11', 91.04, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2325, 1, 'DINNER', '2021-02-07', 62.13, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2326, 1, 'DINNER', '2021-02-03', 98.63, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1921, 1, 'ALDI', '2021-06-24', 79.62, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1922, 1, 'ALDI', '2021-06-04', 17.43, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1923, 1, 'ALDI', '2021-06-13', 44.04, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1960, 1, 'C&A', '2021-08-26', 42.92, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1986, 1, 'EDEKA', '2021-08-13', 72.76, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1987, 1, 'EDEKA', '2021-08-25', 15.96, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1988, 1, 'EDEKA', '2021-08-02', 43.29, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2027, 1, 'EDEKA', '2021-10-06', 39.26, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2028, 1, 'EDEKA', '2021-10-26', 2.91, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2029, 1, 'EDEKA', '2021-10-14', 3.31, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2066, 1, 'DINNER', '2021-11-16', 77.74, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2067, 1, 'DINNER', '2021-11-23', 42.31, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2094, 1, 'REWE', '2021-11-06', 8.47, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2130, 1, 'REWE', '2021-12-20', 45.87, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2131, 1, 'REWE', '2021-12-05', 11.95, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2170, 1, 'HVV', '2021-12-22', 42.79, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2171, 1, 'HVV', '2021-12-06', 58.64, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2172, 1, 'HVV', '2021-12-24', 26.20, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2263, 1, 'DM', '2021-01-28', 42.16, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1817, 1, 'ALDI', '2021-05-29', 98.50, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1819, 1, 'ALDI', '2021-05-28', 81.51, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1924, 1, 'REWE', '2021-06-13', 31.31, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1925, 1, 'REWE', '2021-06-20', 23.45, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1926, 1, 'REWE', '2021-06-27', 57.50, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1961, 1, 'DM', '2021-08-05', 4.28, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1989, 1, 'EDEKA', '2021-08-08', 82.14, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1990, 1, 'EDEKA', '2021-08-05', 65.92, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1991, 1, 'EDEKA', '2021-08-15', 23.51, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2030, 1, 'HVV', '2021-10-16', 34.10, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2031, 1, 'HVV', '2021-10-02', 66.54, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2032, 1, 'HVV', '2021-10-17', 94.14, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2068, 1, 'C&A', '2021-11-02', 35.74, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2069, 1, 'C&A', '2021-11-24', 42.16, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2095, 1, 'DM', '2021-11-13', 94.26, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2132, 1, 'REWE', '2021-12-20', 83.78, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2133, 1, 'REWE', '2021-12-09', 84.66, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2134, 1, 'REWE', '2021-12-27', 97.94, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2173, 1, 'CINEMA', '2021-12-28', 87.11, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2174, 1, 'CINEMA', '2021-12-09', 22.63, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2175, 1, 'CINEMA', '2021-12-17', 22.08, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2264, 1, 'DM', '2021-01-09', 28.81, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1818, 1, 'DEICHMANN', '2021-04-04', 77.73, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1820, 1, 'DEICHMANN', '2021-05-05', 32.81, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1786, 1, 'DM', '2021-03-19', 82.71, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1846, 1, 'REWE', '2021-05-16', 40.03, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1847, 1, 'REWE', '2021-05-17', 20.64, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1848, 1, 'REWE', '2021-05-21', 46.22, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1849, 1, 'REWE', '2021-05-18', 43.71, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2329, 1, 'REWE', '2021-02-05', 85.56, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2330, 1, 'REWE', '2021-02-13', 11.08, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1927, 1, 'EDEKA', '2021-07-03', 80.22, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1928, 1, 'EDEKA', '2021-07-16', 83.95, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1962, 1, 'DM', '2021-08-13', 92.42, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1992, 1, 'DM', '2021-09-07', 20.51, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1993, 1, 'DM', '2021-09-07', 91.27, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2033, 1, 'CINEMA', '2021-10-14', 41.44, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2034, 1, 'CINEMA', '2021-10-10', 83.33, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2035, 1, 'CINEMA', '2021-10-18', 17.41, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2070, 1, 'ALDI', '2021-11-16', 9.41, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2071, 1, 'ALDI', '2021-11-02', 54.30, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2096, 1, 'ALDI', '2021-11-10', 54.77, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2135, 1, 'CAR', '2021-12-22', 38.48, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2136, 1, 'CAR', '2021-12-14', 41.55, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2137, 1, 'CAR', '2021-12-21', 0.55, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2176, 1, 'C&A', '2021-12-07', 76.86, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2177, 1, 'C&A', '2021-12-13', 75.65, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2178, 1, 'C&A', '2021-12-17', 81.50, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2369, 1, 'DM', '2021-02-10', 11.01, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2265, 1, 'DM', '2021-01-04', 64.50, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2266, 1, 'DM', '2021-01-10', 10.77, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2267, 1, 'DM', '2021-01-20', 77.69, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2268, 1, 'DM', '2021-01-28', 42.18, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1821, 1, 'EDEKA', '2021-05-27', 16.36, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1929, 1, 'CAR', '2021-07-19', 56.22, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1930, 1, 'CAR', '2021-07-09', 25.08, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1963, 1, 'REWE', '2021-08-08', 2.00, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1994, 1, 'HVV', '2021-09-18', 12.56, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1995, 1, 'HVV', '2021-09-03', 9.16, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2036, 1, 'C&A', '2021-10-06', 80.40, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2037, 1, 'C&A', '2021-10-28', 24.60, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2038, 1, 'C&A', '2021-10-10', 99.06, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2072, 1, 'ALDI', '2021-11-28', 82.74, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2073, 1, 'ALDI', '2021-11-11', 79.91, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2097, 1, 'EDEKA', '2021-12-23', 10.79, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2098, 1, 'EDEKA', '2021-12-12', 76.61, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2099, 1, 'EDEKA', '2021-12-22', 56.28, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2138, 1, 'CINEMA', '2021-12-19', 55.16, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2139, 1, 'CINEMA', '2021-12-10', 35.52, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2140, 1, 'CINEMA', '2021-12-19', 8.84, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2371, 1, 'RENT', '2021-02-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2372, 1, 'RENT', '2021-03-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2373, 1, 'RENT', '2021-04-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2374, 1, 'RENT', '2021-05-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2375, 1, 'RENT', '2021-06-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2269, 1, 'CAR', '2021-01-17', 53.39, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2270, 1, 'CAR', '2021-01-10', 1.93, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2271, 1, 'CAR', '2021-01-18', 74.79, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2272, 1, 'CAR', '2021-01-04', 26.04, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2376, 1, 'RENT', '2021-07-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2377, 1, 'RENT', '2021-08-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2378, 1, 'RENT', '2021-09-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2379, 1, 'RENT', '2021-10-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2380, 1, 'RENT', '2021-11-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2381, 1, 'RENT', '2021-12-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2382, 1, 'TV', '2021-01-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2383, 1, 'TV', '2021-02-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2384, 1, 'TV', '2021-03-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2385, 1, 'TV', '2021-04-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2386, 1, 'TV', '2021-05-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2387, 1, 'TV', '2021-06-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2388, 1, 'TV', '2021-07-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2389, 1, 'TV', '2021-08-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2390, 1, 'TV', '2021-09-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2391, 1, 'TV', '2021-10-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2392, 1, 'TV', '2021-11-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2393, 1, 'TV', '2021-12-15', 17.50, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2394, 1, 'Sky', '2021-01-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2395, 1, 'Sky', '2021-02-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2396, 1, 'Sky', '2021-03-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2397, 1, 'Sky', '2021-04-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2398, 1, 'Sky', '2021-05-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2399, 1, 'Sky', '2021-06-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2400, 1, 'Sky', '2021-07-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2401, 1, 'Sky', '2021-08-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2402, 1, 'Sky', '2021-09-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2403, 1, 'Sky', '2021-10-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2404, 1, 'Sky', '2021-11-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2405, 1, 'Sky', '2021-12-10', 35, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2406, 1, 'Water', '2021-01-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2407, 1, 'Water', '2021-02-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2408, 1, 'Water', '2021-03-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2409, 1, 'Water', '2021-04-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2410, 1, 'Water', '2021-05-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2411, 1, 'Water', '2021-06-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2412, 1, 'Water', '2021-07-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2413, 1, 'Water', '2021-08-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2414, 1, 'Water', '2021-09-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2415, 1, 'Water', '2021-10-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2416, 1, 'Water', '2021-11-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2417, 1, 'Water', '2021-12-12', 25.5, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2419, 1, 'Water', '2021-02-02', 85, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2420, 1, 'Water', '2021-03-03', 85, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2421, 1, 'Water', '2021-04-04', 85, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2422, 1, 'Water', '2021-05-05', 85, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2423, 1, 'Water', '2021-06-05', 90, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2424, 1, 'Water', '2021-07-05', 90, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2425, 1, 'Water', '2021-08-05', 90, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2426, 1, 'Water', '2021-09-05', 100, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2427, 1, 'Water', '2021-10-05', 100, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2428, 1, 'Water', '2021-11-05', 100, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2429, 1, 'Water', '2021-12-05', 100, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2370, 1, 'RENT', '2021-01-03', 1150, NULL, 'housing', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2418, 1, 'Water', '2021-01-01', 30, NULL, 'utilities', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1757, 1, 'HVV', '2021-03-06', 91.40, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1758, 1, 'HVV', '2021-03-15', 61.61, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1791, 1, 'EDEKA', '2021-03-05', 52.12, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1792, 1, 'EDEKA', '2021-03-11', 14.24, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1793, 1, 'EDEKA', '2021-03-10', 84.20, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1794, 1, 'EDEKA', '2021-03-22', 11.65, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1822, 1, 'RYANAIR', '2021-05-29', 58.45, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2333, 1, 'ALDI', '2021-03-01', 56.47, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1931, 1, 'DINNER', '2021-07-19', 46.13, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1932, 1, 'DINNER', '2021-07-23', 11.80, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1964, 1, 'DM', '2021-08-01', 53.16, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1996, 1, 'COFFEE', '2021-09-14', 43.52, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1997, 1, 'COFFEE', '2021-09-09', 9.27, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2039, 1, 'ALDI', '2021-10-04', 97.50, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2040, 1, 'ALDI', '2021-10-10', 76.70, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2041, 1, 'ALDI', '2021-10-25', 54.25, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2074, 1, 'REWE', '2021-11-12', 96.20, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2075, 1, 'REWE', '2021-11-22', 9.30, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2100, 1, 'RYANAIR', '2021-12-08', 59.00, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2101, 1, 'RYANAIR', '2021-12-28', 28.09, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2102, 1, 'RYANAIR', '2021-12-14', 21.11, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2141, 1, 'C&A', '2021-12-11', 27.14, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2142, 1, 'C&A', '2021-12-04', 11.88, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2143, 1, 'C&A', '2021-12-15', 4.77, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2179, 1, 'REWE', '2021-12-17', 64.39, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2182, 1, 'REWE', '2021-12-12', 85.18, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2183, 1, 'REWE', '2021-12-22', 31.95, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2273, 1, 'CINEMA', '2021-01-18', 75.55, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2274, 1, 'CINEMA', '2021-01-23', 88.82, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2275, 1, 'CINEMA', '2021-01-05', 91.04, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2276, 1, 'CINEMA', '2021-01-13', 8.73, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1759, 1, 'CINEMA', '2021-03-18', 4.30, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1760, 1, 'CINEMA', '2021-03-14', 75.92, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1795, 1, 'EDEKA', '2021-03-03', 87.92, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1823, 1, 'COFFEE', '2021-04-17', 11.53, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2335, 1, 'DM', '2021-02-24', 4.19, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2336, 1, 'DM', '2021-02-22', 53.74, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2338, 1, 'DM', '2021-02-06', 14.55, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1933, 1, 'DEICHMANN', '2021-07-11', 99.36, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1934, 1, 'DEICHMANN', '2021-07-21', 49.60, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1965, 1, 'CAR', '2021-08-14', 16.14, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1998, 1, 'C&A', '2021-09-23', 7.16, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1999, 1, 'C&A', '2021-09-16', 19.29, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2042, 1, 'REWE', '2021-10-29', 14.51, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2043, 1, 'REWE', '2021-10-23', 88.61, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2044, 1, 'REWE', '2021-10-08', 0.23, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2076, 1, 'REWE', '2021-11-26', 29.50, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2077, 1, 'REWE', '2021-11-02', 69.21, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2103, 1, 'COFFEE', '2021-12-06', 59.36, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2104, 1, 'COFFEE', '2021-12-07', 41.09, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2105, 1, 'COFFEE', '2021-12-03', 12.36, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1761, 1, 'C&A', '2021-03-09', 20.02, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1762, 1, 'C&A', '2021-03-28', 84.12, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1796, 1, 'REWE', '2021-03-20', 9.77, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1824, 1, 'C&A', '2021-04-23', 96.55, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2339, 1, 'CAR', '2021-02-09', 81.44, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2340, 1, 'CAR', '2021-02-22', 80.10, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1935, 1, 'DM', '2021-07-02', 4.19, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1936, 1, 'DM', '2021-07-06', 77.92, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (1966, 1, 'COFFEE', '2021-08-13', 16.48, NULL, 'hobbies', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2000, 1, 'DM', '2021-09-08', 80.08, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2001, 1, 'DM', '2021-09-27', 69.74, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2045, 1, 'DM', '2021-10-04', 75.31, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2046, 1, 'DM', '2021-10-05', 48.25, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2047, 1, 'DM', '2021-10-24', 75.68, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2078, 1, 'RYANAIR', '2021-11-15', 82.99, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2079, 1, 'RYANAIR', '2021-11-12', 52.46, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2106, 1, 'DEICHMANN', '2021-12-08', 39.71, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2107, 1, 'DEICHMANN', '2021-12-11', 99.65, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2108, 1, 'DEICHMANN', '2021-12-16', 99.48, NULL, 'personal_spending', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2342, 1, 'CAR', '2021-02-02', 87.47, NULL, 'transportation', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2281, 1, 'REWE', '2021-01-20', 94.34, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2282, 1, 'REWE', '2021-01-15', 85.30, NULL, 'food', NULL);
INSERT INTO transactions (id, account_id, payee, date_trans, amount, group_name, category, description) VALUES (2284, 1, 'REWE', '2021-01-17', 24.60, NULL, 'food', NULL);





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