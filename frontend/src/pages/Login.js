import React, { useState } from "react";
import {Button, Form, Row, Col} from "react-bootstrap";
import Swal from 'sweetalert2'
import axios from "axios";
import Cookies from "universal-cookie";

const Login = () => {

    const cookies = new Cookies();

    const [userData, setUserData] = useState({
        email: '',
        password: ''
    })

    const handleLogin = async () => {
        if (userData.email === '' || userData.password === '') {
            Swal.fire("Error", "User and Password must be provide", "warning").then()
        } else {
            const json = {
                email: userData.email,
                password: userData.password
            }
            await axios.post(process.env.REACT_APP_API_ROUTE + 'user/login/', json)
                .then(response => {
                    return response.data
                })
                .then(response => {
                    cookies.set('id', response['result'][0].id, {path: "/"})
                    cookies.set('name', response['result'][0].name, {path: "/"})
                    window.location.href="./landing";
                })
                .catch( () => {
                    Swal.fire("Error", "Credentials does not match", "error").then()
                })
        }
    }

    const handleInputChange = (e) => {
        setUserData({
            ...userData,
            [e.target.name]: e.target.value
        })
    }

    return (
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
                        <Form.Group className="mb-2" controlId="formBasicEmail">
                            <Form.Label>Email address</Form.Label>
                            <Form.Control
                                type="email"
                                placeholder="Enter email"
                                name="email"
                                onChange={handleInputChange}
                            />
                            <Form.Text className="text-muted">
                                We'll never share your email with anyone else.
                            </Form.Text>
                        </Form.Group>
                        <Form.Group className="mb-3" controlId="formBasicPassword">
                            <Form.Label>Password</Form.Label>
                            <Form.Control
                                type="password"
                                placeholder="Password"
                                name="password"
                                onChange={handleInputChange}
                            />
                        </Form.Group>
                        <Button variant="primary" onClick={() => handleLogin()}>
                            Login
                        </Button>
                    </Form>
                </Col>
            </Row>
        </div>
    );
};

export default Login;