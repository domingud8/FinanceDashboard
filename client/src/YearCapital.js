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
        <div>
            <p> Hello {year} !!! </p>
            <p>Total Income: {totalIncome}</p>
            <p>Total Expenses: {totalOutcome}</p>
            <p>Total Savings: {totalSavings}</p>

            {totalOutcomeCategoryPercentage.map((item, index) => {
                return (
                    <li key={index}>
                        {" "}
                        {item.category} {item.total} ({item.percentage}%)
                    </li>
                );
            })}
        </div>
    );
}
