import "../style.css";
import GeneralTable from "./GeneralTable";
import Summary from "./Summary";
import Dashboard from "./Dashboard";
import { BrowserRouter, NavLink, Switch, Route } from "react-router-dom";
import TableAddData from "./TableAddData";
import TableAddDataIncome from "./TableAddDataIncome";

import { useState } from "react";

export default function App() {
    const [month, setMonth] = useState("2021-01");
    const [update, SetUpdate] = useState("false");

    function onSelectMonth(month) {
        setMonth(month);
    }

    function onUpdate() {
        SetUpdate(!update);
    }

    return (
        <div className="App">
            <BrowserRouter>
                <header>
                    <nav>
                        <NavLink exact to="/">
                            Monthly control
                        </NavLink>
                        <NavLink exact to="/dashboard">
                            Year summary
                        </NavLink>
                    </nav>
                </header>
                <main>
                    <Switch>
                        <Route path="/" exact>
                            <div className="overview-container">
                                <div className="summary">
                                    <Summary month={month} update={update} />
                                </div>
                                <div className="general-table">
                                    <GeneralTable
                                        onSelectMonth={onSelectMonth}
                                        defaultMonth={month}
                                        onUpdate={onUpdate}
                                        update
                                    />
                                    <br /> <br />
                                    <TableAddData onUpdate={onUpdate} />
                                    <br /> <br />
                                    <TableAddDataIncome onUpdate={onUpdate} />
                                </div>
                            </div>
                        </Route>
                        <Route path="/dashboard" exact>
                            <Dashboard />
                        </Route>
                    </Switch>
                </main>
                <footer>@domingud8</footer>
            </BrowserRouter>
        </div>
    );
}
