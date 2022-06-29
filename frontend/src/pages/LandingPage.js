import React, {useEffect} from 'react';
import {NavBar} from "../components/nabvar/NavBar";
import {PieChart} from "../components/piechart/PieChart";
import {Container} from "react-bootstrap"
import Cookies from "universal-cookie";
import Swal from "sweetalert2";
const cookies = new Cookies();

export const LandingPage = () => {

    useEffect(() => {
        if(!cookies.get('id')){
            Swal.fire("Error", "You must be logged in", "error").then( () => {
                window.location.href="./";
            })
        }
    }, []);


    return (
        <Container fluid>
            <NavBar/>
            <PieChart/>
        </Container>
    )
}