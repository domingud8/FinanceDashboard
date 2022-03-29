import "../style.css";
import GeneralTable from "./GeneralTable";
import Summary from "./Summary";
import Dashboard from "./Dashboard";
import { BrowserRouter, NavLink, Switch, Route } from "react-router-dom";
import TableAddData from "./TableAddData";
import { useState } from "react";

export default function App() {
    const [month, setMonth] = useState("");

    function onSelectMonth(month) {
        setMonth(month);
    }
    return (
        <div className="App">
            <BrowserRouter>
                <header>
                    <nav>
                        <NavLink exact to="/">
                            Manage your data
                        </NavLink>
                        <NavLink exact to="/dashboard">
                            Dashborad
                        </NavLink>
                    </nav>
                </header>
                <main>
                    <Switch>
                        <Route path="/" exact>
                            <div className="overview-container">
                                <div className="summary">
                                    <Summary month={month} />
                                </div>
                                <div className="general-table">
                                    <GeneralTable
                                        onSelectMonth={onSelectMonth}
                                    />
                                    <br /> <br />
                                    <TableAddData />
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
