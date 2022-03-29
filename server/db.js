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
function getAccountById(id) {
    return db.query(`SELECT *  FROM account WHERE id=$1`, [id]).then((data) => {
        return data.rows[0];
    });
}

/////NEW

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

module.exports = {
    getDataById,
    getAccountById,
    addTransaction,
    removeTransaction,
    getDataByIdByMonth,
    getDataGroupByCategoryMonth,
    updateTransaction,
    getDataGroupByPayeeCategoryMonth,
};

/*`SELECT id, payee, category, (SELECT EXTRACT(DAY FROM date_trans) AS Day), (SELECT EXTRACT(MONTH FROM date_trans) AS Month), SUM(amount) AS amount_t, group_name, category, description  FROM transactions WHERE account_id=$1 GROUP BY Payee, id ORDER BY Month, Day `;*/
