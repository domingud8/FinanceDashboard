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
});

import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableRow,
} from "@material-ui/core";

import TableWithData from "./TableWithData";

export default function GeneralTable({ onSelectMonth }) {
    const classes = useStyles();
    const [month, setMonth] = useState(null);
    const [data, setData] = useState([]);
    const [inEditMode, setInEditMode] = useState({
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
            });
    }, [inEditMode]);

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
            <p> Transactions </p>
            <div className="form-data-selection">
                <form
                    onSubmit={(event) => {
                        UploadDataByDate(event);
                    }}
                >
                    <input
                        type="month"
                        name="month"
                        onChange={(event) => onChangeDateInput(event)}
                        required
                    />
                    <button className="btn" type="submit">
                        Get data
                    </button>
                </form>
            </div>
            <div>
                {data.length ? (
                    <TableWithData
                        classes={classes}
                        data={data}
                        inEditMode={inEditMode}
                        setInEditMode={setInEditMode}
                        columns={columns}
                    />
                ) : (
                    <Table
                        style={{ marginTop: "30px" }}
                        className={classes.table}
                    >
                        <TableHead>
                            <TableRow>
                                {columns.map((column, index) => {
                                    return (
                                        <TableCell
                                            key={index}
                                            className={classes.tableCell}
                                        >
                                            {column.title}
                                        </TableCell>
                                    );
                                })}
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            <TableRow
                                style={{
                                    height: "30px",
                                }}
                            >
                                <TableCell colSpan={6}>
                                    NO DATA YET, PLEASE GET THE DATA FOR
                                    SPECIFIC MONTH !!
                                </TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                )}
            </div>
        </div>
    );
}
