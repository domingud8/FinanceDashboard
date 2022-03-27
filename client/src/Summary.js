import { useState, useEffect } from "react";

export default function OtherUserProfile() {
    const [data, setData] = useState([]);

    useEffect(() => {
        setData([1, 2]);
    }, []);
    return <div className="summary">Hello {data}</div>;
}
