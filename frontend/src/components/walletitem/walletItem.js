import React, {useEffect, useState} from 'react';
import "./walletItem.css"
import Cookies from "universal-cookie";

let cookies = new Cookies();

export const WalletItem = () => {

    const [data, setData] = useState([])

    useEffect(() => {
        const fetchData = async () => {
            const response = await fetch(process.env.REACT_APP_API_ROUTE + 'wallet/my_wallets/' + cookies.get('id'))
            const result = await response.json()
            setData(result['result'])
        }
        fetchData()
    }, [])

    console.log(data)

    return (
        <tbody>
            {
                data.map((element) => (
                    <tr>
                        <td className="log-table-cell">{element['name']}</td>
                        <td className="log-table-cell">{element['active'].toString()}</td>
                        <td className="log-table-cell">{element['created_at']}</td>
                    </tr>
                ))
            }
        </tbody>
    )
}