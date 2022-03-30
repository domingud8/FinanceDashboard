import { useState, useEffect } from "react";
import { makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles({
    table: {
        minWidth: 0,
        fontSize: "40pt",
        backgroundColor: "rgb(176, 213, 216)",
    },

    tableCell: {
        textAlign: "center",
        padding: "12px 12px 12px 7px",
        fontSize: "20px",
        minWidth: "100px",
        minHeight: "50px",
    },
    inputCell: {
        fontSize: "20px",
        width: "90%",
    },
    tableBody: {
        display: "block",
        maxHeight: "500px",
        overflow: "auto",
    },
    tableHead: {
        display: "table",
        width: "100%",
        tableLayout: "fixed",
    },
    tableRow: {
        display: "table",
        width: "100%",
        tableLayout: "fixed",
    },
});

import TableWithData from "./TableWithData";
import TableWithDataIncome from "./TableWithDataIncome";

import TableWOData from "./TableWOData";

export default function GeneralTable({
    onSelectMonth,
    defaultMonth,
    onUpdate,
    update,
}) {
    const classes = useStyles();
    const [month, setMonth] = useState(defaultMonth);

    const [data, setData] = useState([]);
    const [inEditMode, setInEditMode] = useState({
        status: false,
        rowKey: null,
    });

    const [dataIncome, setDataIncome] = useState([]);
    const [inEditModeIncome, setInEditModeIncome] = useState({
        status: false,
        rowKey: null,
    });

    const columns = [
        { title: "Payee", field: "payee" },
        { title: "Date", field: "date" },
        { title: "Amount", field: "amount", type: "numeric" },
        { title: "Category", field: "category" },
        { title: "Group", field: "group" },
        { title: "Description", field: "description" },
        { title: "Action", field: "Action" },
    ];

    const columnsIncome = [
        { title: "Date", field: "date" },
        { title: "Amount", field: "amount", type: "numeric" },
        { title: "Category", field: "category" },
    ];

    useEffect(() => {
        fetch("/api/transactions/month", {
            method: "POST",
            body: JSON.stringify({
                month: defaultMonth,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                setData(data);
                onUpdate();
            });

        fetch("/api/income/month", {
            method: "POST",
            body: JSON.stringify({
                month: defaultMonth,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                setDataIncome(data);
                onUpdate();
            });
    }, []);

    useEffect(() => {
        fetch("/api/transactions/month", {
            method: "POST",
            body: JSON.stringify({
                month: month,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                setData(data);

                onUpdate();
            });
    }, [inEditMode, update, month]);

    useEffect(() => {
        fetch("/api/income/month", {
            method: "POST",
            body: JSON.stringify({
                month: month,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                setDataIncome(data);
                onUpdate();
            });
    }, [inEditModeIncome, update, month]);

    function UploadDataByDate(event) {
        event.preventDefault();
        setMonth(event.target.month.value);
        onSelectMonth(event.target.month.value);
        fetch("/api/transactions/month", {
            method: "POST",
            body: JSON.stringify({
                month: event.target.month.value,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                setData(data);
                onUpdate();
            });

        fetch("/api/income/month", {
            method: "POST",
            body: JSON.stringify({
                month: event.target.month.value,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                setDataIncome(data);
                onUpdate();
            });
    }

    function onChangeDateInput(event) {
        event.preventDefault();
    }

    return (
        <div
            style={{ maxWidth: "100%" }}
            className="container-form-transactions"
        >
            {month ? (
                <div>
                    Your ar currently watching the data for month: {month}
                </div>
            ) : (
                <div>
                    Your ar currently watching the data for month:
                    {defaultMonth}
                </div>
            )}
            <div className="form-data-selection">
                <form
                    onSubmit={(event) => {
                        UploadDataByDate(event);
                    }}
                >
                    <input
                        type="month"
                        name="month"
                        defaultValue={defaultMonth}
                        onChange={(event) => onChangeDateInput(event)}
                        required
                    />
                    <button className="btn" type="submit">
                        Get data
                    </button>
                </form>
            </div>
            <div>
                <p className="text-uppercase">Transactions</p>
                {data.length ? (
                    <TableWithData
                        classes={classes}
                        data={data}
                        inEditMode={inEditMode}
                        setInEditMode={setInEditMode}
                        columns={columns}
                        onUpdate
                    />
                ) : (
                    <div>
                        <TableWOData classes={classes} columns={columns} />
                    </div>
                )}
            </div>

            <div>
                <p className="text-uppercase">Income</p>
                {dataIncome.length ? (
                    <TableWithDataIncome
                        classes={classes}
                        data={dataIncome}
                        inEditMode={inEditModeIncome}
                        setInEditMode={setInEditModeIncome}
                        columns={columnsIncome}
                        onUpdate
                    />
                ) : (
                    <div>
                        <TableWOData
                            classes={classes}
                            columns={columnsIncome}
                        />
                    </div>
                )}
            </div>
        </div>
    );
}
