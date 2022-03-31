import { useState, useEffect } from "react";

export default function YearCapital({ year }) {
    const [totalIncome, setTotalIncome] = useState([]);
    const [totalOutcome, setTotalOutcome] = useState([]);

    const [totalOutcomeCategory, setTotalOutcomeCategory] = useState([]);
    const [totalOutcomeCategoryPercentage, setTotalOutcomeCategoryPercentage] =
        useState([]);

    const [totalSavings, setTotalSavings] = useState([]);

    useEffect(() => {
        fetch("/api/income/year", {
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
                setTotalIncome(data.total);
            });

        fetch("/api/spend/year", {
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
                setTotalOutcome(data.total);
            });

        fetch("/api/spend/category/year", {
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
                setTotalOutcomeCategory(data);
            });
    }, [year]);

    useEffect(() => {
        const savings = (totalIncome - totalOutcome).toFixed(2);
        setTotalSavings(savings);
    }, [totalSavings, totalIncome, totalOutcome]);

    useEffect(() => {
        const percentageList = [];
        Promise.all(
            totalOutcomeCategory.map((item) => {
                const percentage = ((item.total / totalIncome) * 100).toFixed(
                    2
                );
                percentageList.push({
                    ...item,
                    percentage: percentage,
                });
            })
        ).then(() => {
            setTotalOutcomeCategoryPercentage(percentageList);
        });
    }, [totalOutcomeCategory, totalIncome]);

    return (
        <div className="numbersContainer">
            <div className="vertical">
                <div className="verticalCell">
                    <p> Summary in numbers</p>
                </div>
            </div>
            <div className="numbers">
                <div className="boxColor">
                    <p>
                        Total Income <br />
                        <br /> <span> {totalIncome} &#8364;</span>
                    </p>
                </div>
                <div className="boxColor">
                    <p>
                        Total Expenses <br /> <br />{" "}
                        <span>
                            {" "}
                            {totalOutcome} &#8364; <br />{" "}
                            <span className="red-text">
                                (
                                {((totalOutcome / totalIncome) * 100).toFixed(
                                    2
                                )}
                                % ){" "}
                            </span>
                            <br />
                        </span>
                    </p>
                </div>
                <div className="boxColor">
                    <p>
                        Total Savings <br /> <br />
                        <span>
                            {" "}
                            {totalSavings} &#8364;
                            <br />{" "}
                            <span className="red-text">
                                (
                                {((totalSavings / totalIncome) * 100).toFixed(
                                    2
                                )}
                                % ){" "}
                            </span>
                            <br />
                        </span>
                    </p>
                </div>
            </div>
            <div className="ListCategoryYearSummary">
                <ul>
                    {totalOutcomeCategoryPercentage.map((item, index) => {
                        return (
                            <li key={index}>
                                {item.category}:{" "}
                                <span>
                                    {item.total} &#8364;{" "}
                                    <span className="red-text">
                                        ({item.percentage} %)
                                    </span>
                                </span>
                            </li>
                        );
                    })}
                </ul>
            </div>
        </div>
    );
}
