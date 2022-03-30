import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableRow,
} from "@material-ui/core";

export default function TableWOData({ classes, columns }) {
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
                <TableRow
                    style={{
                        height: "30px",
                    }}
                >
                    <TableCell colSpan={6}>NO DATA YET!! </TableCell>
                </TableRow>
            </TableBody>
        </Table>
    );
}
