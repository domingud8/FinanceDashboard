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

import TableCellCustomized from "./TableCellCustomized";

export default function TableWithDataIncome({
    classes,
    data,
    inEditMode,
    setInEditMode,
    columns,
    onUpdate,
}) {
    const [id, setId] = useState(null);
    const [date_trans, setDateTrans] = useState(null);
    const [amount, setAmount] = useState(null);
    const [category, setCategory] = useState(null);

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
    }
    function OnClickEditIcon({ row, row_id }) {
        setInEditMode({ status: true, rowKey: row_id });
        setId(row.id);
        setDateTrans(row.date);
        setAmount(row.amount);
        setCategory(row.category);
    }

    function onSaveData() {
        console.log("onSave");
        const modified_row = {
            id,
            date_trans,
            amount,
            category,
        };

        fetch("/api/income", {
            method: "PUT",
            body: JSON.stringify(modified_row),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((d) => {
                console.log(d);
                setInEditMode({ status: !inEditMode.status, rowKey: null });
                setId(null);
                setDateTrans(null);
                setAmount(null);
                setCategory(null);
                setShowConfirmSave(false);
                onUpdate();
            });
    }

    function onRemoveData() {
        fetch("/api/income", {
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
                setDateTrans(null);
                setAmount(null);
                setCategory(null);
                setShowConfirmDelete(false);
                onUpdate();
            });
    }
    function onCancelModify() {
        setInEditMode({ status: !inEditMode.status, rowKey: null });
        setId(null);

        setDateTrans(null);
        setAmount(null);
        setCategory(null);
    }
    return (
        <Table style={{ marginTop: "30px" }} className={classes.table}>
            <TableHead className={classes.tableHead}>
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
            <TableBody className={classes.tableBody}>
                {data.map((row, index) => {
                    return (
                        <TableRow className={classes.tableRow} key={index}>
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
                            <TableCell className={classes.tableCell}>
                                {inEditMode.status &&
                                inEditMode.rowKey === index ? (
                                    <div>
                                        <DeleteForeverIcon
                                            style={{ paddingRight: "8px" }}
                                            onClick={handleDelete}
                                        />
                                        <SaveAltIcon
                                            style={{ paddingRight: "8px" }}
                                            onClick={handleSave}
                                        />
                                        <CancelIcon
                                            style={{ paddingRight: "8px" }}
                                            onClick={onCancelModify}
                                        />
                                    </div>
                                ) : (
                                    <EditIcon
                                        onClick={() =>
                                            OnClickEditIcon({
                                                row,
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
                        <Button onClick={handleNo} color="primary" autoFocus>
                            No
                        </Button>
                    </DialogActions>
                </Dialog>
            )}
            {showConfirmDelete && (
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
            )}
        </Table>
    );
}
