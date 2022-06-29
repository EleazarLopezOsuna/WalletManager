import React from 'react';
import {Button, Col, Container, Form, Row} from "react-bootstrap";
import Cookies from "universal-cookie";
import {NavBar} from "../components/nabvar/NavBar";

let cookies = new Cookies();

export const Transaction = () => {
    
    cookies.set('filter', 'full', {path: "/"})
    cookies.set('wallet', '1', {path: "/"})

    const handleFilter = async () => {
        window.location.href="./transactions";
    }

    const handleInputChange = (e) => {
        cookies.set(e.target.name, e.target.value, {path: "/"})
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
                <Row className="justify-content-md-center">
                    <Col>
                        <Form>
                            <Form.Group className="mb-3">
                                <Form.Label>Select Filter</Form.Label>
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
                            <Form.Group className="mb-3" controlId="formBasicPassword">
                                <Form.Label>Date</Form.Label>
                                <Form.Control
                                    type="text"
                                    placeholder="Day | Month | Year"
                                    name="date"
                                    onChange={handleInputChange}
                                />
                            </Form.Group>
                            <Form.Group className="mb-3">
                                <Form.Label>Select Wallet</Form.Label>
                                <Form.Select aria-label="Default select example"
                                             name="wallet"
                                             onChange={handleInputChange}>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </Form.Select>
                            </Form.Group>
                            <Form.Group className="mb-3">
                                <Form.Control
                                    type="button"
                                    value="Filter"
                                    onClick={() => handleFilter()}
                                />
                            </Form.Group>
                        </Form>
                    </Col>
                </Row>
            </div>
        </Container>
    )
}