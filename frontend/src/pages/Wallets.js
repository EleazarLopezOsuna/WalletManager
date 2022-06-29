import React from 'react';
import {WalletItem} from "../components/walletitem/walletItem";
import {NavBar} from "../components/nabvar/NavBar";
import {Container} from "react-bootstrap";
import "./table.scss"
export const Wallets = () => {

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