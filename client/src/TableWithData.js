import { useState } from "react";

import {
    Button,
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableRow,
} from "@material-ui/core";

import CancelIcon from "@material-ui/icons/Cancel";
import SaveAltIcon from "@material-ui/icons/SaveAlt";
import DeleteForeverIcon from "@material-ui/icons/DeleteForever";
import EditIcon from "@material-ui/icons/Edit";

import Dialog from "@material-ui/core/Dialog";
import DialogActions from "@material-ui/core/DialogActions";
import DialogContent from "@material-ui/core/DialogContent";
import DialogContentText from "@material-ui/core/DialogContentText";
import DialogTitle from "@material-ui/core/DialogTitle";

function TableCellCustomized({
    classes,
    inEditMode,
    index,
    row_value,
    cell,
    id,
    getInputFromChild,
}) {
    function SendInput(event) {
        getInputFromChild(event.target.value, cell, id);
    }
    return (
        <TableCell className={classes.tableCell}>
            {inEditMode.status && inEditMode.rowKey === index ? (
                <input
                    className={classes.inputCell}
                    name={cell}
                    defaultValue={row_value}
                    onInput={(event) => SendInput(event)}
                />
            ) : (
                row_value
            )}
        </TableCell>
    );
}

export default function TableWithData({
    classes,
    data,
    inEditMode,
    setInEditMode,
    columns,
}) {
    const [id, setId] = useState(null);
    const [payee, setPayee] = useState(null);
    const [date_trans, setDateTrans] = useState(null);
    const [amount, setAmount] = useState(null);
    const [category, setCategory] = useState(null);
    const [group_name, setGroupName] = useState(null);
    const [description, setDescription] = useState(null);

    const [showConfirmSave, setShowConfirmSave] = useState(false);
    const [showConfirmDelete, setShowConfirmDelete] = useState(false);

    const handleSave = () => {
        setShowConfirmSave(true);
    };

    const handleNo = () => {
        setShowConfirmSave(false);
    };

    const handleDelete = () => {
        setShowConfirmDelete(true);
    };

    const handleNoDelete = () => {
        setShowConfirmDelete(false);
    };

    function getInputFromChild(input, cell) {
        if (cell === "payee") {
            setPayee(input);
            return;
        }
        if (cell === "date_trans") {
            setDateTrans(input);
            return;
        }
        if (cell === "amount") {
            setAmount(input);
            return;
        }
        if (cell === "category") {
            setCategory(input);
            return;
        }
        if (cell === "group_name") {
            setGroupName(input);
            return;
        }
        if (cell === "description") {
            setDescription(input);
            return;
        }
    }
    function OnClickEditIcon({ row, row_id }) {
        setInEditMode({ status: true, rowKey: row_id });
        setId(row.id);
        setPayee(row.payee);
        setDateTrans(row.date);
        setAmount(row.amount);
        setCategory(row.category);
        setGroupName(row.group_name);
        setDescription(row.description);
    }

    function onSaveData() {
        const modified_row = {
            id,
            payee,
            date_trans,
            amount,
            category,
            group_name,
            description,
        };

        fetch("/api/transactions", {
            method: "PUT",
            body: JSON.stringify(modified_row),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then(() => {
                setInEditMode({ status: !inEditMode.status, rowKey: null });
                setId(null);
                setPayee(null);
                setDateTrans(null);
                setAmount(null);
                setCategory(null);
                setGroupName(null);
                setDescription(null);
                setShowConfirmSave(false);
            });
    }

    function onRemoveData() {
        fetch("/api/transactions", {
            method: "DELETE",
            body: JSON.stringify({ id }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then(() => {
                setInEditMode({ status: !inEditMode.status, rowKey: null });
                setId(null);
                setPayee(null);
                setDateTrans(null);
                setAmount(null);
                setCategory(null);
                setGroupName(null);
                setDescription(null);
                setShowConfirmDelete(false);
            });
    }
    function onCancelModify() {
        setInEditMode({ status: !inEditMode.status, rowKey: null });
        setId(null);
        setPayee(null);
        setDateTrans(null);
        setAmount(null);
        setCategory(null);
        setGroupName(null);
        setDescription(null);
    }
    return (
        <Table style={{ marginTop: "30px" }} className={classes.table}>
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
                {data.map((row, index) => {
                    return (
                        <TableRow key={index}>
                            <TableCellCustomized
                                classes={classes}
                                inEditMode={inEditMode}
                                index={index}
                                row_value={row.payee}
                                cell="payee"
                                id={row.id}
                                getInputFromChild={getInputFromChild}
                            />
                            <TableCellCustomized
                                classes={classes}
                                inEditMode={inEditMode}
                                index={index}
                                row_value={row.date}
                                cell="date"
                                getInputFromChild={getInputFromChild}
                            />
                            <TableCellCustomized
                                classes={classes}
                                inEditMode={inEditMode}
                                index={index}
                                row_value={row.amount}
                                cell="amount"
                                getInputFromChild={getInputFromChild}
                            />
                            <TableCellCustomized
                                classes={classes}
                                inEditMode={inEditMode}
                                index={index}
                                row_value={row.category}
                                cell="category"
                                getInputFromChild={getInputFromChild}
                            />
                            <TableCellCustomized
                                classes={classes}
                                inEditMode={inEditMode}
                                index={index}
                                row_value={row.group_name}
                                cell="group_name"
                                getInputFromChild={getInputFromChild}
                            />
                            <TableCellCustomized
                                classes={classes}
                                inEditMode={inEditMode}
                                index={index}
                                row_value={row.description}
                                cell="description"
                                getInputFromChild={getInputFromChild}
                            />
                            <TableCell className={classes.tableCell}>
                                {inEditMode.status &&
                                inEditMode.rowKey === index ? (
                                    <div>
                                        <DeleteForeverIcon
                                            style={{ paddingRight: "8px" }}
                                            onClick={() => handleDelete()}
                                        />
                                        <SaveAltIcon
                                            style={{ paddingRight: "8px" }}
                                            onClick={() => handleSave()}
                                        />
                                        <CancelIcon
                                            style={{ paddingRight: "8px" }}
                                            onClick={() => onCancelModify()}
                                        />
                                    </div>
                                ) : (
                                    <EditIcon
                                        onClick={() =>
                                            OnClickEditIcon({
                                                row: row,
                                                row_id: index,
                                            })
                                        }
                                    />
                                )}
                            </TableCell>
                        </TableRow>
                    );
                })}
            </TableBody>
            {showConfirmSave && (
                <div>
                    <Dialog
                        open={showConfirmSave}
                        onClose={handleNo}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <DialogTitle id="alert-dialog-title">
                            {"Confirm Save"}
                        </DialogTitle>
                        <DialogContent>
                            <DialogContentText id="alert-dialog-description">
                                Are you sure to save changes?
                            </DialogContentText>
                        </DialogContent>
                        <DialogActions>
                            <Button
                                onClick={() => onSaveData()}
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
            {showConfirmDelete && (
                <div>
                    <Dialog
                        open={showConfirmDelete}
                        onClose={handleNoDelete}
                        aria-labelledby="alert-dialog-title"
                        aria-describedby="alert-dialog-description"
                    >
                        <DialogTitle id="alert-dialog-title">
                            {"Confirm Save"}
                        </DialogTitle>
                        <DialogContent>
                            <DialogContentText id="alert-dialog-description">
                                Are you sure to delete entry?
                            </DialogContentText>
                        </DialogContent>
                        <DialogActions>
                            <Button
                                onClick={() => onRemoveData()}
                                color="primary"
                                autoFocus
                            >
                                Yes
                            </Button>
                            <Button
                                onClick={handleNoDelete}
                                color="primary"
                                autoFocus
                            >
                                No
                            </Button>
                        </DialogActions>
                    </Dialog>
                </div>
            )}
        </Table>
    );
}
