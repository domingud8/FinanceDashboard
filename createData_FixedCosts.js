const spicedPg = require("spiced-pg");

let db;
if (process.env.DATABASE_URL) {
    db = spicedPg(process.env.DATABASE_URL);
    console.log("social network running on Heroku");
} else {
    const { DB_USER, DB_PASS } = require("./secrets.json");
    const DATABASE_NAME = "finance";
    console.log(`[db] Connecting locally to: ${DATABASE_NAME}`);
    db = spicedPg(
        `postgres:${DB_USER}:${DB_PASS}@localhost:5432/${DATABASE_NAME}`
    );
}

function getRandomEntryFromArray(array) {
    return array[Math.floor(Math.random() * array.length)];
}

const payees = {
    housing: ["RENT"],
    utilities: ["TV", "Sky", "Water", "EON"],
};

async function generateEntries(category) {
    const payee = getRandomEntryFromArray(payees[category]);
    return db.query(
        `INSERT INTO transactions ( 
            account_id,
            amount,
            category,
            payee,
            date_trans
        ) SELECT 
        1,
        ROUND((random()*100)::numeric , 2 ),
        $1,
        $2,
        DATE(timestamp '2021-02-01 20:00:00' +
            random() * (timestamp '2021-02-28 20:00:00' -
                   timestamp '2021-02-01 10:00:00'))
        FROM generate_series(1,1);    
    `,
        [category, payee, entry]
    );
}

const entry = Math.floor(Math.random() * 5);
Promise.all(
    Object.keys(payees).map((key) => {
        generateEntries(key, entry);
    })
).then(() => console.log("generated many entries!"));

generateEntries("food", entry);
generateEntries("food", entry);
generateEntries("food", entry);
