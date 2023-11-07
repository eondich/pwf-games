import React from 'react';
import { Routes, BrowserRouter as Router, Route } from 'react-router-dom';

import AppHeader from './AppHeader/AppHeader';
import CharacterGeneratorPage from './CharacterGenerator/CharacterGeneratorPage';

const App = () => {
  return (
    <Router>
      <div>
        <AppHeader />
        <Routes>
          <Route path="/" element={<CharacterGeneratorPage />} />
          <Route path="character_generator" element={<CharacterGeneratorPage />} />
        </Routes>
      </div>
    </Router>
  )
};

export default App;
