import { useState, useEffect } from "react";

import YearCapital from "./YearCapital";

import YearPlots from "./YearPlots";
export default function OtherUserProfile() {
    const [year, setYear] = useState("2021");

    function SelectYear(event) {
        event.preventDefault();
        setYear(event.target.year.value);
    }
    useEffect(() => {}, []);
    return (
        <div className="yearDash">
            <div className="formYearSelection">
                <form
                    onSubmit={(event) => {
                        SelectYear(event);
                    }}
                >
                    <input
                        type="year"
                        name="year"
                        defaultValue={"2021"}
                        onChange={(event) => event.preventDefault()}
                        required
                    />
                    <button className="btn" type="submit">
                        Get data
                    </button>
                </form>
            </div>
            <div className="YearCapital">
                <YearCapital year={year} />
            </div>
            <div className="YearPlots">
                <YearPlots year={year} />
            </div>
        </div>
    );
}
