import React from 'react';
import {NavBar} from "../components/nabvar/NavBar";
import {PieChart} from "../components/piechart/PieChart";
import {Container} from "react-bootstrap"

export const LandingPage = () => {

    return (
        <Container fluid>
            <NavBar/>
            <PieChart/>
        </Container>
    )
}