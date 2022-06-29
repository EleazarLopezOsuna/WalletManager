import React from 'react';
import {Container, Nav, Navbar} from "react-bootstrap";

export const NavBar = () => {
    return (
        <Container fluid>
            <Navbar bg="dark" variant="dark">
                <Container>
                    <Navbar.Brand href="/landing">Wallet Manager</Navbar.Brand>
                    <Nav className="me-auto">
                        <Nav.Link href="/wallet">Wallets</Nav.Link>
                        <Nav.Link href="/transaction">Transactions</Nav.Link>
                        <Nav.Link href="/report">Reports</Nav.Link>
                    </Nav>
                    <Nav>
                        <Navbar.Collapse className="justify-content-end">
                            <Nav.Link href="#pricing" className='active'>Logout</Nav.Link>
                        </Navbar.Collapse>
                    </Nav>
                </Container>
            </Navbar>
        </Container>
    )
}