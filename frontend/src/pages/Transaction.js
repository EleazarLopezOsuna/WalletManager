import React, {useEffect, useState} from 'react';
import { Col, Container, Form, Row} from "react-bootstrap";
import Cookies from "universal-cookie";
import {NavBar} from "../components/nabvar/NavBar";
import "./table.scss"
import "./transactionItem.scss"
import Swal from "sweetalert2";

let cookies = new Cookies();


export const TransactionItem = ({state}) => {

    const [data, setData] = useState([])
    useEffect(() => {
        const fetchData = async () => {
            console.log(state)
            let url = process.env.REACT_APP_API_ROUTE
            switch(state['filter']){
                case 'full':
                    url += 'transaction/my_transactions/' + cookies.get('id')
                    break;
                case 'wallet':
                    url += 'transaction/wallet_transactions/' + state['wallet']
                    break;
                case 'category':
                    url += 'transaction/category/' + state['wallet'] + '/' + state['category']
                    break;
                default:
                    url += 'transaction/' + state['filter'] + '/' + state['wallet'] + '/' + state['date']
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

    }, [state])

    return (
        <Container fluid>
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

export const Transaction = () => {


    const [state, setState] = useState({
        filter: 'full',
        wallet: '1',
        category: '1',
        date: ''
    });

    const [categories, setCategories] = useState([])
    const [wallets, setWallets] = useState([])

    useEffect(() => {
        if(!cookies.get('id')){
            Swal.fire("Error", "You must be logged in", "error").then( () => {
                window.location.href="./";
            })
        }

        const fetchData = async () => {
            let response = await fetch(process.env.REACT_APP_API_ROUTE + 'wallet/my_wallets/' + cookies.get('id'))
            let result = await response.json()
            if(response.status === 200)
                setWallets(result['result'])
            else
                setWallets([])

            response = await fetch(process.env.REACT_APP_API_ROUTE + 'category')
            result = await response.json()
            if(response.status === 200)
                setCategories(result['result'])
            else
                setCategories([])
        }
        fetchData()
    }, [])

    const handleInputChange = (e) => {
        setState({
            ...state,
            [e.target.name]: e.target.value
        })
    }

    return (
        <Container fluid>
            <NavBar/>
            <Form>
                <Row className="mb-3">
                    <Form.Group as={Col} controlId="formGridFilter">
                        <Form.Select aria-label="Default select example"
                                     name="filter"
                                     onChange={handleInputChange}>
                            <option value="full" >No Filter</option>
                            <option value="wallet">Wallet</option>
                            <option value="category">Category</option>
                            <option value="date">Day</option>
                            <option value="month">Month</option>
                            <option value="year">Year</option>
                        </Form.Select>
                    </Form.Group>

                    <Form.Group as={Col} controlId="formGridWallet">
                        <Form.Select aria-label="Default select example"
                                     name="wallet"
                                     onChange={handleInputChange}>
                            {
                                wallets.map((element) => (
                                    <option value={element['id']} >{element['name']}</option>
                                ))
                            }
                        </Form.Select>
                    </Form.Group>

                    <Form.Group as={Col} controlId="formGridCategory">
                        <Form.Select aria-label="Default select example"
                                     name="category"
                                     onChange={handleInputChange}>
                            {
                                categories.map((element) => (
                                    <option value={element['id']} >{element['name']}</option>
                                ))
                            }
                        </Form.Select>
                    </Form.Group>

                    <Form.Group as={Col} controlId="formGridDate">
                        <Form.Control
                            type="text"
                            placeholder="Day | Month | Year"
                            name="date"
                            onChange={handleInputChange}
                        />
                    </Form.Group>
                </Row>
            </Form>
            <TransactionItem state={state}/>
        </Container>
    )
}