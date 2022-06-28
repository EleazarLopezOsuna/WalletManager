import React from 'react';
import{ BrowserRouter as Router,  Switch, Route } from "react-router-dom"

import Login from '../pages/Login'
import {LandingPage} from "../pages/LandingPage";

function Routes() {
    return (
      <Router>
        <Switch>
          <Route exact path="/" component={Login}/>
          <Route exact path="/landing" component={LandingPage}/>
        </Switch>
      </Router>
  );
}

export default Routes;
