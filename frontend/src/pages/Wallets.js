import React, {useEffect} from 'react';
import {WalletItem} from "../components/walletitem/walletItem";
import {NavBar} from "../components/nabvar/NavBar";
import {Container} from "react-bootstrap";
import "./table.scss"
import Swal from "sweetalert2";
import Cookies from "universal-cookie";

const cookies = new Cookies();

export const Wallets = () => {

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
            <div className="log-scrollable">
                <table className="log-table">
                    <thead>
                    <tr>
                        <th className="log-table-head">Name</th>
                        <th className="log-table-head">Active</th>
                        <th className="log-table-head">Date</th>
                    </tr>
                    </thead>
                    <WalletItem/>
                </table>
            </div>
        </Container>
    )
}