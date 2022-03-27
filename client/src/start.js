import ReactDOM from "react-dom";

import App from "./App";

fetch("/api/account/mine")
    .then((response) => response.json())
    .then((user) => {
        if (!user) {
            ReactDOM.render(
                "Logout experience ",
                document.querySelector("main")
            );
            return;
        }
        ReactDOM.render(
            <div>
                <App />
            </div>,
            document.querySelector("main")
        );
    });
