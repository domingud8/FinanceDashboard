import { useState, useEffect } from "react";
import Plot from "react-plotly.js";

export default function Summary({ month, update }) {
    ///for the var-cahr plot
    const [keys, setKeys] = useState([]);
    const [yValues, setYValues] = useState([]);

    /// for the pie chart plot
    const [payees, setPayees] = useState([]);
    const [payeesParents, setPayeesParents] = useState([]);
    const [valuesPayees, setValuesPayees] = useState([]);
    const [labelMonth, setLabelMonth] = useState([]);

    const [totalIncome, setTotalIncome] = useState(null);
    const [totalExpenses, setTotalExpenses] = useState(null);
    const [total, setTotal] = useState(null);
    const [totalSave, setTotalSave] = useState(null);

    const xValue = ["Income", "Expenses", "Savings/Lost"];
    const [yValue, setYValue] = useState([]);

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
                        setYValues(valuesInternal);
                        setLabelMonth(labelMonthInternal);
                        setKeys(keysInternal);
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

            fetch("/api/totalIncome/month", {
                method: "POST",
                body: JSON.stringify({ month: monthPart, year: yearPart }),
                headers: { "Content-Type": "application/json" },
            })
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    setTotalIncome(data.total);
                });

            fetch("/api/totalExpenses/month", {
                method: "POST",
                body: JSON.stringify({ month: monthPart, year: yearPart }),
                headers: { "Content-Type": "application/json" },
            })
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    setTotalExpenses(data.total);
                });
        }
    }, [month, update]);

    useEffect(() => {
        setTotal(Math.max(totalIncome, totalExpenses));
        setTotalSave(totalIncome - totalExpenses);
        setYValue([totalIncome, totalExpenses, totalSave]);
    }, [totalIncome, totalExpenses, totalSave]);

    return (
        <div className="summary">
            {keys.length ? (
                <div>
                    <div className="MonthTextSummary">
                        <p> {month} </p>
                    </div>
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
                                autosize: false,
                                margin: { l: 180, r: 10, b: 50, t: 50 },
                                width: 550,
                                height: 350,
                                font: { size: 18 },
                                xaxis: {
                                    title: "&#8364;",
                                    titlefont: { size: 20 },
                                },
                            }}
                        />
                        <Plot
                            data={[
                                {
                                    type: "bar",
                                    x: xValue,
                                    y: yValue,

                                    marker: {
                                        color: [
                                            "rgba(158,202,225,0.5)",
                                            "rgba(255,0,0,0.5)",
                                            "rgba(255,140,0,0.7)",
                                        ],
                                        line: {
                                            color: [
                                                "rgb(158,202,225)",
                                                "rgb(255,0,0)",
                                                "rgb(255,140,0)",
                                            ],
                                            width: 1.5,
                                        },
                                    },
                                },
                            ]}
                            layout={{
                                autosize: false,
                                margin: { l: 80, r: 10, b: 50, t: 50 },
                                width: 550,
                                height: 350,
                                font: { size: 18 },
                                yaxis: {
                                    title: "&#8364;",
                                    titlefont: { size: 20 },
                                },
                            }}
                        />
                    </div>
                </div>
            ) : (
                <div></div>
            )}

            {total ? (
                <div>
                    <Plot
                        data={[
                            {
                                type: "sunburst",

                                labels: ["Month", ...keys, ...payees],

                                parents: ["", ...labelMonth, ...payeesParents],

                                values: [total, ...yValues, ...valuesPayees],

                                outsidetextfont: { size: 20, color: "#377eb8" },
                                leaf: { opacity: 0.4 },
                                marker: { line: { width: 2 } },
                                branchvalues: "total",
                                texttemplate: "%{label}<br>%{value} &#8364;",
                                hovertemplate: "%{percentParent:.1%}",
                            },
                        ]}
                        layout={{
                            margin: { l: 50, r: 10, b: 0, t: 10 },
                            width: 500,
                            height: 500,
                        }}
                    />
                    ;
                </div>
            ) : (
                <div></div>
            )}
        </div>
    );
}
