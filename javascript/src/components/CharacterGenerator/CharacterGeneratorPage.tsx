import React, { useEffect, useState } from "react";

import CharacterGeneratorRoller from "./CharacterGeneratorRoller";
import CharacterGeneratorSheet from "./CharacterGeneratorSheet";

const baseUrl = 'http://localhost:3000/api/v1/character_generator'

const CharacterGeneratorPage = () => {
  // Grab character name from backend
  const [availableAncestries, setAvailableAncestries] = useState([]);
  const [selectedAncestry, setSelectedAncestry] = useState(null);
  const [availableClasses, setAvailableClasses] = useState([]);
  const [selectedClass, setSelectedClass] = useState(null);
  const [selectedCharName, setSelectedCharName] = useState(null);
  const [availableSourceMaterial, setAvailableSourceMaterial] = useState([]);
  const [selectedSourceMaterial, setSelectedSourceMaterial] = useState(null);

  // Fetch character option sources
  useEffect(() => {
    const url = `${baseUrl}/sources`;
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Could not retrieve character option sources");
      })
      .then((res) => {
        setAvailableSourceMaterial(res.sources);
      });
  }, []);

  // Fetch ancestry options based on source materials
  useEffect(() => {
    // Only try to grab this data if we have a source selected
    if (selectedSourceMaterial !== null) {
      const url = `${baseUrl}/ancestries/${selectedSourceMaterial}`;
      fetch(url)
        .then((res) => {
          if (res.ok) {
            return res.json();
          }
          throw new Error("Could not retrieve ancestries");
        })
        .then((res) => {
          setAvailableAncestries(res.ancestries);
        });
    }
  }, [selectedSourceMaterial]);

  // Fetch class options based on source materials
  useEffect(() => {
    // Only try to grab this data if we have a source selected
    if (selectedSourceMaterial !== null) {
      const url = `${baseUrl}/player_classes/${selectedSourceMaterial}`;
      fetch(url)
        .then((res) => {
          if (res.ok) {
            return res.json();
          }
          throw new Error("Could not retrieve player classes");
        })
        .then((res) => {
          setAvailableClasses(res.player_classes);
        });
    }
  }, [selectedSourceMaterial]);


  return (
    <div className="character-generator-page">
      <CharacterGeneratorRoller availableSources={availableSourceMaterial || []}
                                onSelectSource={setSelectedSourceMaterial} />
      <CharacterGeneratorSheet availableAncestries={availableAncestries || []}
                               availableClasses={availableClasses || []}
                               onSelectAncestry={setSelectedAncestry}
                               onSelectClass={setSelectedClass} />
    </div>
  )
}

export default CharacterGeneratorPage;