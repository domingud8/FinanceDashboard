const spicedPg = require("spiced-pg");
/*const bcrypt = require("bcryptjs");*/

let db;
if (process.env.DATABASE_URL) {
    db = spicedPg(process.env.DATABASE_URL);
    console.log("social network running on Heroku");
} else {
    const { DB_USER, DB_PASS } = require("../secrets.json");
    const DATABASE_NAME = "finance";
    console.log(`[db] Connecting locally to: ${DATABASE_NAME}`);
    db = spicedPg(
        `postgres:${DB_USER}:${DB_PASS}@localhost:5432/${DATABASE_NAME}`
    );
}

///// Functions for getting information about ACCOUNT Table
function getAccountById(id) {
    return db.query(`SELECT *  FROM account WHERE id=$1`, [id]).then((data) => {
        return data.rows[0];
    });
}

///// Functions for getting information about INCOME Table

function getIncomeDataByIdByMonth({ month, account_id }) {
    return db
        .query(
            `SELECT  id, category, to_char(date_trans,'YYYY-MM-DD') AS date,  amount
             FROM income
             WHERE to_char(date_trans,'YYYY-MM')=$1 AND account_id=$2 
             ORDER BY date_trans ASC`,
            [month, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

///// Functions for getting information about TRANSACTION Table

function getDataById(account_id) {
    return db
        .query(
            `SELECT id, payee, category, (SELECT EXTRACT(DAY FROM date_trans) AS Day), (SELECT EXTRACT(MONTH FROM date_trans) AS Month),  amount, group_name, category, description  FROM transactions WHERE account_id=$1 ORDER BY Month, Day `,
            [account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function addTransaction({
    account_id,
    payee,
    date_trans,
    amount,
    group_name,
    category,
    description,
}) {
    return db
        .query(
            `INSERT INTO transactions (account_id, payee, date_trans, amount, group_name, category, description)
             VALUES
             ($1,$2,$3,$4,$5,$6,$7) RETURNING * `,
            [
                account_id,
                payee,
                date_trans,
                amount,
                group_name,
                category,
                description,
            ]
        )
        .then((data) => {
            return data.rows[0];
        });
}

function addIncome({ account_id, date_trans, amount, category }) {
    return db
        .query(
            `INSERT INTO income (account_id, date_trans, amount,  category)
             VALUES
             ($1,$2,$3,$4) RETURNING * `,
            [account_id, date_trans, amount, category]
        )
        .then((data) => {
            return data.rows[0];
        });
}

function getTotalIncomeMonth({ account_id, month, year }) {
    return db
        .query(
            `SELECT SUM(amount) as total from income
            WHERE account_id=$1 AND (SELECT EXTRACT(MONTH FROM date_trans))=$2 AND (SELECT EXTRACT(YEAR FROM date_trans))=$3
             `,
            [account_id, month, year]
        )
        .then((data) => {
            return data.rows[0];
        });
}

function getTotalExpensesMonth({ account_id, month, year }) {
    return db
        .query(
            `SELECT SUM(amount) as total from transactions
            WHERE account_id=$1 AND (SELECT EXTRACT(MONTH FROM date_trans))=$2 AND (SELECT EXTRACT(YEAR FROM date_trans))=$3
             `,
            [account_id, month, year]
        )
        .then((data) => {
            return data.rows[0];
        });
}

function removeTransaction({ id, account_id }) {
    return db
        .query(
            `DELETE FROM transactions WHERE id=$1 AND account_id=$2 RETURNING * `,
            [id, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function removeIncome({ id, account_id }) {
    return db
        .query(
            `DELETE FROM income WHERE id=$1 AND account_id=$2 RETURNING * `,
            [id, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function getDataByIdByMonth({ month, account_id }) {
    return db
        .query(
            `SELECT id, payee, amount, category, to_char(date_trans,'YYYY-MM-DD') AS date, description, group_name
             FROM transactions
             WHERE to_char(date_trans,'YYYY-MM')=$1 AND account_id=$2 
             ORDER BY date_trans ASC`,
            [month, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function getDataGroupByCategoryMonth({ month, year, account_id }) {
    return db
        .query(
            ` SELECT category, SUM(amount) AS amount FROM transactions
 WHERE (SELECT EXTRACT(MONTH FROM date_trans))=$1 AND (SELECT EXTRACT(YEAR FROM date_trans))=$2 AND account_id=$3
GROUP BY category;
 `,
            [month, year, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function updateTransaction({
    account_id,
    id,
    payee,
    date_trans,
    amount,
    group_name,
    category,
    description,
}) {
    return db
        .query(
            `UPDATE transactions
            SET payee=$3, date_trans=$4, amount=$5, group_name=$6, category=$7, description=$8
            WHERE id=$2 AND account_id=$1
            RETURNING * `,
            [
                account_id,
                id,
                payee,
                date_trans,
                amount,
                group_name,
                category,
                description,
            ]
        )
        .then((data) => {
            return data.rows;
        });
}

function updateIncome({ account_id, id, date_trans, amount, category }) {
    return db
        .query(
            `UPDATE income
            SET  date_trans=$3, amount=$4, category=$5
            WHERE id=$2 AND account_id=$1
            RETURNING * `,
            [account_id, id, date_trans, amount, category]
        )
        .then((data) => {
            return data.rows;
        });
}

function getDataGroupByPayeeCategoryMonth({ month, year, account_id }) {
    return db
        .query(
            ` SELECT payee, category, SUM(amount) AS amount FROM transactions
 WHERE (SELECT EXTRACT(MONTH FROM date_trans))=$1 AND (SELECT EXTRACT(YEAR FROM date_trans))=$2 AND account_id=$3
GROUP BY payee, category;
 `,
            [month, year, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

//////Getting information about Year///////////

function getTotalIncomeByIdByYear({ year, account_id }) {
    return db
        .query(
            `SELECT   SUM(amount) as total
             FROM income
             WHERE to_char(date_trans,'YYYY')=$1 AND account_id=$2 
             `,
            [year, account_id]
        )
        .then((data) => {
            return data.rows[0];
        });
}

function getTotalSpendByIdByYear({ year, account_id }) {
    return db
        .query(
            `SELECT   SUM(amount) as total
             FROM transactions
             WHERE to_char(date_trans,'YYYY')=$1 AND account_id=$2 
             `,
            [year, account_id]
        )
        .then((data) => {
            return data.rows[0];
        });
}

function getTotalSpendByIdByCategoryByYear({ year, account_id }) {
    return db
        .query(
            `SELECT category,  SUM(amount) as total
             FROM transactions
             WHERE to_char(date_trans,'YYYY')=$1 AND account_id=$2 
             GROUP BY category
             ORDER by total DESC;
             `,
            [year, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function getTimeLineByIdByCategoryByYear({ year, account_id, category }) {
    return db
        .query(
            `SELECT (SELECT EXTRACT(MONTH FROM date_trans)) AS month, SUM(amount) AS total
             FROM transactions 
             WHERE category=$3 AND to_char(date_trans,'YYYY')=$1 AND account_id=$2
             GROUP BY month, category 
             ORDER BY month ASC;
             `,
            [year, account_id, category]
        )
        .then((data) => {
            return data.rows;
        });
}

function getIncomeTimeLineByIdByYear({ year, account_id }) {
    return db
        .query(
            `SELECT (SELECT EXTRACT(MONTH FROM date_trans)) AS month, SUM(amount) AS total
             FROM income 
             WHERE  to_char(date_trans,'YYYY')=$1 AND account_id=$2
             GROUP BY month 
             ORDER BY month ASC;
             `,
            [year, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

function getExpensesTimeLineByIdByYear({ year, account_id }) {
    return db
        .query(
            `SELECT (SELECT EXTRACT(MONTH FROM date_trans)) AS month, SUM(amount) AS total
             FROM transactions 
             WHERE  to_char(date_trans,'YYYY')=$1 AND account_id=$2
             GROUP BY month 
             ORDER BY month ASC;
             `,
            [year, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}
function getPayeeGroupByIdByCategoryByYear({ year, account_id, category }) {
    return db
        .query(
            `SELECT  SUM(amount) AS total, payee
             FROM transactions 
             WHERE category=$3 AND to_char(date_trans,'YYYY')=$1 AND account_id=$2
             GROUP BY payee;
             `,
            [year, account_id, category]
        )
        .then((data) => {
            return data.rows;
        });
}

function getCategoriesLabels({ year, account_id }) {
    return db
        .query(
            `SELECT category 
             FROM transactions 
             WHERE  to_char(date_trans,'YYYY')=$1 AND account_id=$2
             GROUP BY category;
             `,
            [year, account_id]
        )
        .then((data) => {
            return data.rows;
        });
}

module.exports = {
    getDataById,
    getAccountById,
    addTransaction,
    removeTransaction,
    removeIncome,
    getDataByIdByMonth,
    getDataGroupByCategoryMonth,
    updateTransaction,
    getDataGroupByPayeeCategoryMonth,
    getIncomeDataByIdByMonth,
    updateIncome,
    addIncome,
    getTotalIncomeMonth,
    getTotalExpensesMonth,
    getTotalIncomeByIdByYear,
    getTotalSpendByIdByYear,
    getTotalSpendByIdByCategoryByYear,
    getTimeLineByIdByCategoryByYear,
    getPayeeGroupByIdByCategoryByYear,
    getIncomeTimeLineByIdByYear,
    getExpensesTimeLineByIdByYear,
    getCategoriesLabels,
};

/*`SELECT id, payee, category, (SELECT EXTRACT(DAY FROM date_trans) AS Day), (SELECT EXTRACT(MONTH FROM date_trans) AS Month), SUM(amount) AS amount_t, group_name, category, description  FROM transactions WHERE account_id=$1 GROUP BY Payee, id ORDER BY Month, Day `;*/
