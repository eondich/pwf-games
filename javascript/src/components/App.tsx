import React from 'react';
import { Routes, BrowserRouter as Router, Route } from 'react-router-dom';

import AppHeader from './AppHeader/AppHeader';
import Home from './Home';

const App = () => {
  return (
    <Router>
      <div>
        <AppHeader />
        <Routes>
          <Route exact path="/" element={<Home />} />
        </Routes>
      </div>
    </Router>
  )
};

export default App;
