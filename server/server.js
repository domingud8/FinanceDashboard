const express = require("express");
const app = express();
const compression = require("compression");
const path = require("path");
const {
    getAccountById,
    addTransaction,
    removeTransaction,
    getDataByIdByMonth,
    getDataGroupByCategoryMonth,
    updateTransaction,
    getDataGroupByPayeeCategoryMonth,
    getIncomeDataByIdByMonth,
    updateIncome,
    removeIncome,
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

app.post("/api/income/month", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { month } = request.body;
    if (!request.session.account_id) {
        response.json(null);
        return;
    }
    getIncomeDataByIdByMonth({ month: month, account_id: account_id })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.put("/api/income", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { id, date_trans, amount, category } = request.body;
    console.log("UPDATING DATA INCOME", {
        account_id,
        id,
        date_trans,
        amount,
        category,
    });
    updateIncome({
        account_id,
        id,
        date_trans,
        amount,
        category,
    })
        .then((data) => {
            console.log("updated data", data);
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

app.delete("/api/income", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { id } = request.body;

    removeIncome({ id, account_id })
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

app.post("/api/income", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { date_trans, amount, category } = request.body;

    addIncome({
        account_id,
        date_trans,
        amount,
        category,
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

app.post("/api/totalIncome/month", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { month, year } = request.body;
    console.log("/api/totalIncome/month", month, year);
    getTotalIncomeMonth({
        account_id,
        month,
        year,
    })
        .then((data) => {
            console.log(data);
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

app.post("/api/totalExpenses/month", (request, response) => {
    const account_id = USER_ID; //request.session.account_id
    const { month, year } = request.body;
    getTotalExpensesMonth({
        account_id,
        month,
        year,
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

///////////////////////
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

app.post("/api/groupByCategory", (request, response) => {
    const account_id = USER_ID; // request.session.account_id = 1;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    //const initial_date = "2022-01-05";
    //const final_date = "2022-01-08";

    const { month, year } = request.body;
    console.log(month, year);
    getDataGroupByCategoryMonth({
        month,
        year,
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

app.post("/api/groupByPayeeCategory", (request, response) => {
    const account_id = USER_ID; // request.session.account_id = 1;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/

    const { month, year } = request.body;

    getDataGroupByPayeeCategoryMonth({
        month,
        year,
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

///////////End-points for Year Dashboard ///////////
app.post("/api/income/year", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getTotalIncomeByIdByYear({ year: year, account_id: account_id })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/spend/year", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getTotalSpendByIdByYear({ year: year, account_id: account_id })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/spend/category/year", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getTotalSpendByIdByCategoryByYear({ year: year, account_id: account_id })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/category/year/timeline", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year, category } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getTimeLineByIdByCategoryByYear({
        year: year,
        account_id: account_id,
        category: category,
    })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/category/year/payee", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year, category } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getPayeeGroupByIdByCategoryByYear({
        year: year,
        account_id: account_id,
        category: category,
    })
        .then((data) => {
            console.log(data);
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/income/year/timeline", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getIncomeTimeLineByIdByYear({
        year: year,
        account_id: account_id,
    })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/expenses/year/timeline", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getExpensesTimeLineByIdByYear({
        year: year,
        account_id: account_id,
    })
        .then((data) => {
            response.json(data);
        })
        .catch((error) => {
            console.log("[error getting data]", error);
            response.status(500).json({ error_message: "Error getting data" });
        });
});

app.post("/api/categoriesLabel/year", (request, response) => {
    const account_id = USER_ID; ///request.session.account_id
    const { year } = request.body;
    /*if (!request.session.account_id) {
        response.json(null);
        return;
    }*/
    getCategoriesLabels({
        year: year,
        account_id: account_id,
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
