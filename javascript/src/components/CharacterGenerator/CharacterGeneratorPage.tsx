import React, { useEffect, useState } from "react";

import CharacterGeneratorRoller from "./CharacterGeneratorRoller";
import CharacterCard from "../Cards/CharacterCard";
import "./CharacterGeneratorPage.scss";

const baseUrl = 'http://localhost:3000/api/v1/character_generator';

const CharacterGeneratorPage = () => {
  const [availableAncestries, setAvailableAncestries] = useState([]);
  const [selectedAncestry, setSelectedAncestry] = useState(null);
  const [sheetAncestry, setSheetAncestry] = useState(null);
  const [availableClasses, setAvailableClasses] = useState([]);
  const [selectedClass, setSelectedClass] = useState(null);
  const [sheetClass, setSheetClass] = useState(null);
  const [availableGenders, setAvailableGenders] = useState([]);
  const [availableSourceMaterial, setAvailableSourceMaterial] = useState([]);
  const [selectedSourceMaterial, setSelectedSourceMaterial] = useState(null);

  // FETCHING DATA
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

  // Fetch gender options
  useEffect(() => {
    const url = `${baseUrl}/genders`;
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Could not retrieve gender options");
      })
      .then((res) => {
        setAvailableGenders();
      });
  }, [])

  // FUNCTIONS
  function generateCharacter() {
    if (selectedSourceMaterial) {
      if (selectedAncestry) {
        setSheetAncestry(selectedAncestry);
      } else {
        const ancestryIndex = Math.floor(Math.random() * (availableAncestries.length))
        setSheetAncestry(availableAncestries[ancestryIndex].id);
      }

      if (selectedClass) {
        setSheetClass(selectedClass);
      } else {
        const classIndex = Math.floor(Math.random() * (availableClasses.length))
        setSheetClass(availableClasses[classIndex].id);
      }
    }
  }

  return (
    <div className="character-generator-page">
      <CharacterGeneratorRoller availableAncestries={availableAncestries || []}
                                availableClasses={availableClasses || []}
                                availableGenders={availableGenders || []}
                                availableSources={availableSourceMaterial || []}
                                onRoll={generateCharacter}
                                onSelectAncestry={setSelectedAncestry}
                                onSelectClass={setSelectedClass}
                                onSelectGender={() => {}}
                                onSelectSource={setSelectedSourceMaterial} />
      <CharacterCard availableAncestries={availableAncestries || []}
                     availableClasses={availableClasses || []}
                     selectedAncestry={sheetAncestry}
                     selectedClass={sheetClass} />
    </div>
  )
}

export default CharacterGeneratorPage;