import React from 'react';
import { Routes, BrowserRouter as Router, Route } from 'react-router-dom';

import AppHeader from './AppHeader/AppHeader';
import FollowerGenerator from './FollowerGenerator/FollowerGenerator';

const App = () => {
  return (
    <Router>
      <div>
        <AppHeader />
        <Routes>
          <Route exact path="/" element={<FollowerGenerator />} />
        </Routes>
      </div>
    </Router>
  )
};

export default App;
