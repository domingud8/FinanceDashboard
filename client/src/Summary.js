import { useState, useEffect } from "react";
import Plot from "react-plotly.js";

export default function OtherUserProfile({ month }) {
    ///for the var-cahr plot
    const [keys, setKeys] = useState([]);
    const [yValues, setYValues] = useState([]);

    /// for the pie chart plot
    const [payees, setPayees] = useState([]);
    const [payeesParents, setPayeesParents] = useState([]);
    const [valuesPayees, setValuesPayees] = useState([]);
    const [labelMonth, setLabelMonth] = useState([]);

    useEffect(() => {
        const date = month.split("-");
        const monthPart = date[1];
        const yearPart = date[0];
        if (month) {
            fetch("/api/groupByCategory", {
                method: "POST",
                body: JSON.stringify({ month: monthPart, year: yearPart }),
                headers: { "Content-Type": "application/json" },
            })
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    const keysInternal = [];
                    const valuesInternal = [];
                    const labelMonthInternal = [];
                    Promise.all(
                        data.map((d) => {
                            keysInternal.push(d.category);
                            valuesInternal.push(d.amount);
                            labelMonthInternal.push("Month");
                        })
                    ).then(() => {
                        setKeys(keysInternal);
                        setYValues(valuesInternal);
                        setLabelMonth(labelMonthInternal);
                    });
                });

            fetch("/api/groupByPayeeCategory", {
                method: "POST",
                body: JSON.stringify({ month: monthPart, year: yearPart }),
                headers: { "Content-Type": "application/json" },
            })
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    const payeeInternal = [];
                    const valuesPayeeInternal = [];
                    const parentsPayeeInternal = [];
                    Promise.all(
                        data.map((d) => {
                            if (d.payee) {
                                payeeInternal.push(d.payee);
                                valuesPayeeInternal.push(d.amount);
                                parentsPayeeInternal.push(d.category);
                            }
                        })
                    ).then(() => {
                        setPayees(payeeInternal);
                        setValuesPayees(valuesPayeeInternal);
                        setPayeesParents(parentsPayeeInternal);
                    });
                });
        }
    }, [month]);

    useEffect(() => {
        console.log("payees", payees);
        console.log("valuesPayees", valuesPayees);
        console.log("payeesParents", payeesParents);
        console.log("LabelMonth", labelMonth);
    }, [payees, valuesPayees, payeesParents, labelMonth]);

    return (
        <div className="summary">
            {keys.length ? (
                <div>
                    <Plot
                        data={[
                            {
                                type: "bar",
                                y: keys,
                                x: yValues,
                                orientation: "h",
                                marker: {
                                    color: "rgba(50,171,96,0.6)",
                                    line: {
                                        color: "rgba(50,171,96,1.0)",
                                        width: 2,
                                    },
                                },
                            },
                        ]}
                        layout={{
                            width: 400,
                            height: 400,
                            title: "Bar Char Horizontal Plot",
                        }}
                    />

                    <Plot
                        data={[
                            {
                                type: "sunburst",

                                labels: ["Month", ...keys, ...payees],

                                parents: ["", ...labelMonth, ...payeesParents],

                                values: [7000, ...yValues, ...valuesPayees],

                                outsidetextfont: { size: 20, color: "#377eb8" },
                                leaf: { opacity: 0.4 },
                                marker: { line: { width: 2 } },
                                branchvalues: "total",
                            },
                        ]}
                        layout={{
                            margin: { l: 0, r: 0, b: 0, t: 0 },

                            width: 500,

                            height: 500,
                        }}
                    />
                </div>
            ) : (
                <div>
                    {" "}
                    Selected Month {month} {keys.length}{" "}
                </div>
            )}
        </div>
    );
}
