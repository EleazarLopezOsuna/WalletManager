import React, { useState, useEffect } from "react";
import {Button, Form, Row, Col, Container} from "react-bootstrap";
import Swal from 'sweetalert2'
import axios from "axios";
import Cookies from "universal-cookie";
import {NavBar} from "../components/nabvar/NavBar";

let cookies = new Cookies();

export const CreateTransaction = () => {

    const [categories, setCategories] = useState([])
    const [wallets, setWallets] = useState([])
    const [state, setState] = useState({
        wallet: '1',
        category: '1',
        description: '',
        amount: ''
    });

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

    const handleCreate = async () => {
        if (state.description === '' || state.amount === '') {
            Swal.fire("Error", "Description and Amount must be provided", "warning").then()
        } else {
            const json = {
                wallet_id: state.wallet,
                category_id: state.category,
                description: state.description,
                amount: state.amount
            }
            await axios.post(process.env.REACT_APP_API_ROUTE + 'transaction', json)
                .then(response => {
                    return response.data
                })
                .then( () => {
                    console.log('b')
                    Swal.fire("Success", "Transaction created successfully", "success").then( () => {
                        window.location.href="./new_transaction";
                    })
                })
                .catch( () => {
                    Swal.fire("Error", "Credentials does not match", "error").then()
                })
        }
    }

    return (
        <Container fluid>
            <NavBar/>
            <div
                style={{
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center"
                }}
            >
                <Form>
                    <Row className="mb-3">
                        <Form.Group as={Col} controlId="formGridWallet">
                            <Form.Label>Wallet</Form.Label>
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
                            <Form.Label>Category</Form.Label>
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
                    </Row>

                    <Form.Group className="mb-3" controlId="formGridDescription">
                        <Form.Label>Description</Form.Label>
                        <Form.Control
                            type="text"
                            name="description"
                            onChange={handleInputChange}
                        />
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="formGridAmount">
                        <Form.Label>Amount</Form.Label>
                        <Form.Control
                            type="number"
                            name="amount"
                            onChange={handleInputChange}
                        />
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="formGridButton">
                        <Button variant="secondary" onClick={() => handleCreate()}>
                            Create
                        </Button>
                    </Form.Group>
                </Form>
            </div>
        </Container>
    );
};