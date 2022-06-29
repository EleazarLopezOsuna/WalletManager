import React, {useEffect, useState} from 'react';
import "./transactionItem.scss"
import Cookies from "universal-cookie";
import {NavBar} from "../components/nabvar/NavBar";
import {Container} from "react-bootstrap";

let cookies = new Cookies();

export const TransactionItem = () => {

    const [data, setData] = useState([])

    useEffect(() => {
        const fetchData = async () => {
            let url = process.env.REACT_APP_API_ROUTE
            switch(cookies.get('filter')){
                case 'full':
                    url += 'transaction/my_transactions/' + cookies.get('id')
                    break;
                case 'wallet':
                    url += 'transaction/wallet_transactions/' + cookies.get('wallet')
                    break;
                case 'category':
                    break;
                default:
                    url += 'transaction/' + cookies.get('filter') + '/' + cookies.get('wallet') + '/' + cookies.get('date')
                    break;
            }
            const response = await fetch(url)
            const result = await response.json()
            if(response.status === 200)
                setData(result['result'])
            else
                setData([])
        }
        fetchData()
    }, [])

    return (
        <Container fluid>
            <NavBar/>
            <div className="log-scrollable">
                <table className="log-table">
                    <thead>
                    <tr>
                        <th className="log-table-head">Name</th>
                        <th className="log-table-head">Amount</th>
                        <th className="log-table-head">Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    {
                        data.map((element) => (
                            <tr>
                                <td className="log-table-cell">{element['description']}</td>
                                <td className="log-table-cell">{element['amount'].toString()}</td>
                                <td className="log-table-cell">{element['created_at']}</td>
                            </tr>
                        ))
                    }
                    </tbody>
                </table>
            </div>
        </Container>
    )
}