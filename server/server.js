const express = require("express");
const app = express();
const compression = require("compression");
const path = require("path");
const {
    getAccountById,
    addTransaction,
    removeTransaction,
    getDataByIdByMonth,
    getDataGroupByPayeeIntervalTime,
    updateTransaction,
} = require("./db");
const cookieSession = require("cookie-session");
app.use(compression());

app.use(express.static(path.join(__dirname, "..", "client", "public")));

app.use(express.json());
app.use(
    cookieSession({
        secret: `I'm always angry.`,
        maxAge: 1000 * 60 * 60 * 24 * 14,
        sameSite: true,
    })
);

const USER_ID = 1;

app.get("/api/account/mine", (request, response) => {
    request.session.account_id = USER_ID;
    if (!request.session.account_id) {
        response.json(null);
        return;
    }
    getAccountById(1)
        .then((account) => {
            response.json(account);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

/*app.get("/api/transactions", (request, response) => {
    request.session.account_id = 1;
    if (!request.session.account_id) {
        response.json(null);
        return;
    }
    getDataById(1)
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});*/

app.post("/api/transactions/month", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { month } = request.body;
    if (!request.session.account_id) {
        response.json(null);
        return;
    }
    getDataByIdByMonth({ month: month, account_id: account_id })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

///end point to add new entry into transactions table
app.post("/api/transactions", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { payee, date_trans, amount, group_name, category, description } =
        request.body;

    addTransaction({
        account_id,
        payee,
        date_trans,
        amount,
        group_name,
        category,
        description,
    })
        .then((data) => {
            return response.status(200).json(data);
        })
        .catch((error) => {
            console.log(
                "error while updating database transactions in column: ",
                error.column
            );
            response.status(500).json({
                error_message: `Missing data in column ${error.column}`,
            });
        });
});

/////end-point for updating data
app.put("/api/transactions", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { id, payee, date_trans, amount, group_name, category, description } =
        request.body;

    updateTransaction({
        account_id,
        id,
        payee,
        date_trans,
        amount,
        group_name,
        category,
        description,
    })
        .then((data) => {
            return response.status(200).json(data);
        })
        .catch((error) => {
            console.log(
                "error while updating database transactions in column: ",
                error.column
            );
            response.status(500).json({
                error_message: `Missing data in column ${error.column}`,
            });
        });
});

//////end point for deleting specific entry
app.delete("/api/transactions", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { id } = request.body;

    removeTransaction({ id, account_id })
        .then((data) => {
            if (!data.length) {
                return response.status(500).json({
                    error_message: `Unsuccessful deleting transaction `,
                });
            }
            return response.status(200).json(data[0]);
        })
        .catch((error) => {
            console.log(
                "error while deleting entry in database transactions",
                error
            );
            response.status(500).json({
                error_message: `Error while trying to delete entry in transactions database`,
            });
        });
});

app.get("/api/groupby", (request, response) => {
    const account_id = 1; // request.session.account_id = 1;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    //const initial_date = "2022-01-05";
    //const final_date = "2022-01-08";
    const { initial_date, final_date } = request.body;
    getDataGroupByPayeeIntervalTime({
        initial_date,
        final_date,
        account_id,
    })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.get("*", function (req, res) {
    res.sendFile(path.join(__dirname, "..", "client", "index.html"));
});

app.listen(process.env.PORT || 3030, function () {
    console.log("I'm listening.");
});
