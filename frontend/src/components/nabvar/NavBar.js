import React from 'react';
import {Container, Nav, Navbar} from "react-bootstrap";
import Cookies from "universal-cookie";

export const NavBar = () => {

    const cookies = new Cookies();

    const logout = () => {
        cookies.remove('id', {path: "/"})
        cookies.remove('name', {path: "/"})
        window.location.href="./"
    }

    return (
        <Container fluid>
            <Navbar bg="dark" variant="dark">
                <Container>
                    <Navbar.Brand href="/landing">Wallet Manager</Navbar.Brand>
                    <Nav className="me-auto">
                        <Nav.Link href="/wallet">Wallets</Nav.Link>
                        <Nav.Link href="/transaction">Transactions</Nav.Link>
                        <Nav.Link href="/new_transaction">New Transaction</Nav.Link>
                        <Nav.Link href="/report">Reports</Nav.Link>
                    </Nav>
                    <Nav>
                        <Navbar.Collapse className="justify-content-end">
                            <Nav.Link href="#" className='active' onClick={() => logout() }>Logout</Nav.Link>
                        </Navbar.Collapse>
                    </Nav>
                </Container>
            </Navbar>
        </Container>
    )
}