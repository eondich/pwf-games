import React, { useEffect, useState } from "react";

import CharacterGeneratorRoller from "./CharacterGeneratorRoller";
import CharacterCard from "../Cards/CharacterCard";
import "./CharacterGeneratorPage.scss";

interface CharacterGeneratorProps {
  gameSystemName: string
}

const baseUrl = 'http://localhost:3000/api/v1/character_generator';

const CharacterGeneratorPage = (props: CharacterGeneratorProps) => {
  const [availableAncestries, setAvailableAncestries] = useState([]);
  const [selectedAncestry, setSelectedAncestry] = useState("");
  const [sheetAncestry, setSheetAncestry] = useState("");
  const [availableClasses, setAvailableClasses] = useState([]);
  const [selectedClass, setSelectedClass] = useState("");
  const [sheetClass, setSheetClass] = useState("");
  const [availableGenders, setAvailableGenders] = useState([]);
  const [selectedNameGender, setSelectedNameGender] = useState("any");
  const [characterName, setCharacterName] = useState("");
  const [gameSystem, setGameSystem] = useState(null);

  // FETCHING DATA
  // Fetch game system ID
  useEffect(() => {
    const url = `${baseUrl}/system_id/${props.gameSystemName}`;
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Could not retrieve game system");
      })
      .then((res) => {
        setGameSystem(Number(res.system_id));
      });
  }, []);

  // Fetch ancestry options based on source materials
  useEffect(() => {
    const url = `${baseUrl}/ancestries/${gameSystem}`;
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
  }, [gameSystem]);

  // Fetch class options based on source materials
  useEffect(() => {
    // Only try to grab this data if we have a source selected
    if (gameSystem) {
      const url = `${baseUrl}/player_classes/${gameSystem}`;
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
  }, [gameSystem]);

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
        setAvailableGenders(res.gender_options);
      });
  }, [])

  // FUNCTIONS
  function generateCharacter() {
    let ancestryId = selectedAncestry;
    if (selectedAncestry) {
      setSheetAncestry(selectedAncestry);
    } else {
      const ancestryIndex = Math.floor(Math.random() * (availableAncestries.length))
      ancestryId = availableAncestries[ancestryIndex].id
      setSheetAncestry(ancestryId);
    }

    if (selectedClass) {
      setSheetClass(selectedClass);
    } else {
      const classIndex = Math.floor(Math.random() * (availableClasses.length))
      setSheetClass(availableClasses[classIndex].id);
    }

    fetchCharacterName(gameSystem, ancestryId, selectedNameGender);
  }

  function fetchCharacterName(systemId, ancestryId, gender) {
    const url = `${baseUrl}/character_name/${systemId}/${ancestryId}/${gender}`
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Could not retrieve character name");
      })
      .then((res) => {
        setCharacterName(res.character_name);
      })
  }

  return (
    <div className="character-generator-page">
      <CharacterGeneratorRoller availableAncestries={availableAncestries || []}
                                availableClasses={availableClasses || []}
                                availableGenders={availableGenders || []}
                                onRoll={generateCharacter}
                                onSelectAncestry={setSelectedAncestry}
                                onSelectClass={setSelectedClass}
                                onSelectGender={setSelectedNameGender}
                                systemName={props.gameSystemName} />
      <CharacterCard availableAncestries={availableAncestries || []}
                     availableClasses={availableClasses || []}
                     presetCharName={characterName}
                     selectedAncestry={sheetAncestry}
                     selectedClass={sheetClass} />
    </div>
  )
}

export default CharacterGeneratorPage;