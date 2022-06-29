import React from 'react';
import{ BrowserRouter as Router,  Switch, Route } from "react-router-dom"

import Login from '../pages/Login'
import {LandingPage} from "../pages/LandingPage";
import {Wallets} from "../pages/Wallets";
import {Transaction} from "../pages/Transaction";
import {TransactionItem} from "../pages/TransactionItem";
import {CreateTransaction} from "../pages/CreateTransaction";

function Routes() {
    return (
      <Router>
        <Switch>
          <Route exact path="/" component={Login}/>
          <Route exact path="/landing" component={LandingPage}/>
          <Route exact path="/wallet" component={Wallets}/>
          <Route exact path="/transaction" component={Transaction}/>
          <Route exact path="/new_transaction" component={CreateTransaction}/>
        </Switch>
      </Router>
  );
}

export default Routes;
