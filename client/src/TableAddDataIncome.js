import { useState } from "react";

import {
    Button,
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableRow,
} from "@material-ui/core";

import AddBoxIcon from "@material-ui/icons/AddBox";
import DoneIcon from "@material-ui/icons/Done";
import ClearIcon from "@material-ui/icons/Clear";
import Dialog from "@material-ui/core/Dialog";
import DialogActions from "@material-ui/core/DialogActions";
import DialogContent from "@material-ui/core/DialogContent";
import DialogContentText from "@material-ui/core/DialogContentText";
import DialogTitle from "@material-ui/core/DialogTitle";
import { makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles({
    table: {
        minWidth: 0,
        fontSize: "40pt",
        backgroundColor: "rgb(176, 213, 216)",
    },
    tableCell: {
        padding: "2px 12px 2px 7px",
        fontSize: "20px",
        minWidth: "100px",
        minHeight: "50px",
    },
    inputCell: {
        marginTop: "5px",
        marginBottom: "5px",
        minHeight: "25px",
        fontSize: "15px",
        width: "90%",
    },
    selectCell: {
        marginTop: "5px",
        marginBottom: "5px",
        minHeight: "30px",
        minWidth: "140px",
        padding: "2px 12px 2px 7px",
        fontSize: "15px",
        width: "110%",
    },
});

const columns = [
    { title: "Date", field: "date" },
    { title: "Amount", field: "amount", type: "numeric" },
    { title: "Category", field: "category" },
    { title: "Action", field: "Action" },
];

const categories = ["salary"];

export default function TableAddDataIncome({ onUpdate }) {
    const classes = useStyles();
    const [rows, setRows] = useState([]);
    // Initial states
    const [isEdit, setEdit] = useState(false);
    const [disable, setDisable] = useState(true);
    const [showConfirm, setShowConfirm] = useState(false);

    const handleAdd = () => {
        setRows([
            ...rows,
            {
                id: rows.length + 1,
                date_trans: "",
                amount: "",
                category: "",
            },
        ]);
        setEdit(true);
    };

    const handleSave = () => {
        setShowConfirm(true);
    };

    const handleConfirmSave = () => {
        setEdit(!isEdit);

        rows.map((row) => {
            fetch("/api/income", {
                method: "POST",
                body: JSON.stringify(row),
                headers: { "Content-Type": "application/json" },
            })
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    console.log("[post]", data);
                    onUpdate();
                });
        });

        setRows([]);
        setDisable(true);
        setShowConfirm(false);
    };
    const handleInputChange = (event, index) => {
        event.preventDefault();
        setDisable(false);
        const { name, value } = event.target;
        const list = [...rows];
        list[index][name] = value;
        setRows(list);
    };

    const handleRemove = (event, i) => {
        event.preventDefault();
        const list = [...rows];
        list.splice(i, 1);
        setRows(list);
        if (rows.length == 1) {
            setEdit(false);
        }
    };

    const handleNo = () => {
        setShowConfirm(false);
    };

    return (
        <div>
            {isEdit ? (
                <div>
                    <Button onClick={handleAdd}>
                        <AddBoxIcon onClick={handleAdd} />
                        ADD DATA INCOME
                    </Button>
                    {rows.length !== 0 && (
                        <div>
                            {disable ? (
                                <Button
                                    disabled
                                    align="right"
                                    onClick={handleSave}
                                >
                                    <DoneIcon />
                                    SAVE
                                </Button>
                            ) : (
                                <Button align="right" onClick={handleSave}>
                                    <DoneIcon />
                                    SAVE
                                </Button>
                            )}
                        </div>
                    )}
                </div>
            ) : (
                <div>
                    <Button onClick={handleAdd}>
                        <AddBoxIcon onClick={handleAdd} />
                        ADD DATA INCOME
                    </Button>
                </div>
            )}

            {showConfirm && (
                <div>
                    <Dialog
                        open={showConfirm}
                        onClose={handleNo}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <DialogTitle id="alert-dialog-title">
                            {"Confirm Save"}
                        </DialogTitle>
                        <DialogContent>
                            <DialogContentText id="alert-dialog-description">
                                Are you sure to save data?
                            </DialogContentText>
                        </DialogContent>
                        <DialogActions>
                            <Button
                                onClick={() => handleConfirmSave()}
                                color="primary"
                                autoFocus
                            >
                                Yes
                            </Button>
                            <Button
                                onClick={handleNo}
                                color="primary"
                                autoFocus
                            >
                                No
                            </Button>
                        </DialogActions>
                    </Dialog>
                </div>
            )}
            {isEdit ? (
                <Table className={classes.table} size="small">
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
                        {rows.map((row, i) => {
                            return (
                                <TableRow key={row.id}>
                                    <TableCell className={classes.tableCell}>
                                        <input
                                            className={classes.inputCell}
                                            type="date"
                                            value={row.date_trans}
                                            name="date_trans"
                                            onChange={(e) =>
                                                handleInputChange(e, i)
                                            }
                                            required
                                        />
                                    </TableCell>
                                    <TableCell className={classes.tableCell}>
                                        <input
                                            className={classes.inputCell}
                                            value={row.amount}
                                            name="amount"
                                            onChange={(e) =>
                                                handleInputChange(e, i)
                                            }
                                            required
                                        />
                                    </TableCell>
                                    <TableCell className={classes.tableCell}>
                                        <select
                                            className={classes.selectCell}
                                            name="category"
                                            onChange={(e) =>
                                                handleInputChange(e, i)
                                            }
                                        >
                                            <option
                                                selected={true}
                                                value=""
                                                disabled="disabled"
                                            >
                                                Select a category
                                            </option>
                                            {categories.map((category, c) => {
                                                return (
                                                    <option
                                                        key={c}
                                                        value={category}
                                                    >
                                                        {category}
                                                    </option>
                                                );
                                            })}
                                            <option value="">Other</option>
                                        </select>
                                    </TableCell>

                                    <TableCell className={classes.tableCell}>
                                        <Button
                                            onClick={(e) => handleRemove(e, i)}
                                        >
                                            <ClearIcon />
                                        </Button>
                                    </TableCell>
                                </TableRow>
                            );
                        })}
                    </TableBody>
                </Table>
            ) : (
                <div></div>
            )}
        </div>
    );
}
