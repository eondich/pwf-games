import React from 'react';
import { Routes, BrowserRouter as Router, Route } from 'react-router-dom';

import AppHeader from './AppHeader/AppHeader';
import CharacterGeneratorPage from './CharacterGenerators/CharacterGeneratorPage';

const App = () => {
  const gameSystems = {
    'dnd5e': 'Dungeons & Dragons'
  }

  return (
    <Router>
      <div>
        <AppHeader />
        <Routes>
          <Route path="/" element={<CharacterGeneratorPage gameSystemName={gameSystems['dnd5e']} />} />
          <Route path="character_generator" element={<CharacterGeneratorPage gameSystemName={gameSystems['dnd5e']} />} />
        </Routes>
      </div>
    </Router>
  )
};

export default App;
