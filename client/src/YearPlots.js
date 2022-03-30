import { useState, useEffect } from "react";
import Plot from "react-plotly.js";
export default function YearPlots({ year }) {
    const [timeLineValues, setTimeLineValues] = useState([]);
    const months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
    ];
    const [defaultValue, setDefaultValue] = useState("food");
    const [payeeLabels, setPayeesLabels] = useState([]);
    const [payeeValues, setPayeesValues] = useState([]);
    const [timeLineExpensesValue, setTimeLineExpensesValue] = useState([]);
    const [timeLineSavingsValue, setTimeLineSavingsValue] = useState([]);
    const [timeLineIncomeValue, setTimeLineIncomeValue] = useState([]);

    const [categoriesLabels, setCategoriesLabels] = useState([]);
    useEffect(() => {
        fetch("/api/category/year/timeline", {
            method: "POST",
            body: JSON.stringify({
                year: year,
                category: "food",
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const values = [];
                data.map((item) => {
                    values.push(item.total);
                });
                setTimeLineValues(values);
            });

        fetch("/api/category/year/payee", {
            method: "POST",
            body: JSON.stringify({
                year: year,
                category: "food",
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const values = [];
                const labels = [];
                data.map((item) => {
                    values.push(item.total);
                    labels.push(item.payee);
                });
                setPayeesValues(values);
                setPayeesLabels(labels);
            });

        fetch("/api/expenses/year/timeline", {
            method: "POST",
            body: JSON.stringify({
                year: year,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const values = [];

                data.map((item) => {
                    values.push(item.total);
                });
                setTimeLineExpensesValue(values);
            });

        fetch("/api/income/year/timeline", {
            method: "POST",
            body: JSON.stringify({
                year: year,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const values = [];
                data.map((item) => {
                    values.push(item.total);
                });
                setTimeLineIncomeValue(values);
            });

        fetch("/api/categoriesLabel/year", {
            method: "POST",
            body: JSON.stringify({
                year: year,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const labels = [];
                data.map((item) => {
                    labels.push(item.category);
                });
                setCategoriesLabels(labels);
            });
    }, [year]);

    useEffect(() => {
        const values = [];
        timeLineExpensesValue.map((exp, index) => {
            values.push(timeLineIncomeValue[index] - exp);
        });

        setTimeLineSavingsValue(values);
    }, [timeLineIncomeValue]);

    function onSelectCategory(event) {
        event.preventDefault();
        const category = event.target.category.value;
        fetch("/api/category/year/timeline", {
            method: "POST",
            body: JSON.stringify({
                year: year,
                category: category,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const values = [];
                data.map((item) => {
                    values.push(item.total);
                });
                setTimeLineValues(values);
            });

        fetch("/api/category/year/payee", {
            method: "POST",
            body: JSON.stringify({
                year: year,
                category: category,
            }),
            headers: {
                "Content-type": "application/json",
            },
        })
            .then((response) => response.json())

            .then((data) => {
                const values = [];
                const labels = [];
                data.map((item) => {
                    values.push(item.total);
                    labels.push(item.payee);
                });
                setPayeesValues(values);
                setPayeesLabels(labels);
            });
    }

    function handleOnChangeInput(event) {
        event.preventDefault();
        setDefaultValue(event.target.value);
    }
    return (
        <div>
            <div>
                <form
                    onSubmit={(event) => {
                        onSelectCategory(event);
                    }}
                >
                    <select
                        name="category"
                        value={defaultValue}
                        onChange={(event) => {
                            handleOnChangeInput(event);
                        }}
                    >
                        {categoriesLabels.map((category, c) => {
                            return (
                                <option key={c} value={category}>
                                    {category}
                                </option>
                            );
                        })}
                    </select>
                    <button className="btn" type="submit">
                        Get data
                    </button>
                </form>
                <Plot
                    data={[
                        {
                            x: months,

                            y: timeLineValues,

                            type: "scatter",

                            mode: "lines+markers",

                            marker: { color: "red" },
                        },
                    ]}
                    layout={{ width: 600, height: 400, margin: 0, padding: 0 }}
                />

                <Plot
                    data={[
                        {
                            values: payeeValues,

                            labels: payeeLabels,

                            type: "pie",
                        },
                    ]}
                    layout={{ width: 600, height: 400, margin: 0, padding: 0 }}
                />
            </div>
            <div>
                <Plot
                    data={[
                        {
                            x: months,

                            y: timeLineSavingsValue,

                            type: "scatter",

                            mode: "lines+markers",

                            name: "SAVINGS",

                            marker: { color: "red" },
                        },
                        {
                            x: months,

                            y: timeLineExpensesValue,

                            type: "scatter",

                            mode: "lines+markers",

                            name: "Expenses",

                            marker: { color: "blue" },
                        },
                        {
                            x: months,

                            y: timeLineIncomeValue,

                            type: "scatter",

                            mode: "lines+markers",

                            name: "INCOME",

                            marker: { color: "green" },
                        },
                    ]}
                    layout={{ width: 600, height: 400, margin: 0, padding: 0 }}
                />
            </div>
        </div>
    );
}
