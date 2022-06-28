import React from 'react';
import Cookies from "universal-cookie";
import {Container, Nav, Navbar, NavLink, ListGroup} from "react-bootstrap";

export const NavBar = () => {
    let cookies = new Cookies();
    return (
        <Container fluid>
            <Navbar bg="dark" variant="dark">
                <Container>
                    <Navbar.Brand href="#home">Wallet Manager</Navbar.Brand>
                    <Nav className="me-auto">
                        <Nav.Link href="#home">Wallets</Nav.Link>
                        <Nav.Link href="#features">Transactions</Nav.Link>
                        <Nav.Link href="#pricing">Reports</Nav.Link>
                    </Nav>
                    <Nav>
                        <Navbar.Collapse className="justify-content-end">
                            <Navbar.Text>
                                Signed as {cookies.get('name')}
                            </Navbar.Text>
                            <Nav.Link href="#pricing" className='active'>Logout</Nav.Link>
                        </Navbar.Collapse>
                    </Nav>
                </Container>
            </Navbar>
        </Container>
    )
}