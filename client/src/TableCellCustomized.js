import { TableCell } from "@material-ui/core";

export default function TableCellCustomized({
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
