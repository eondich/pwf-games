import React, { useEffect, useState } from "react";

import StandardTable from "../standardComponents/standardTable/StandardTable";
import StandardDropdown from "../standardComponents/standardDropdown/StandardDropdown";
import StandardButton from "../standardComponents/standardButton/StandardButton";

import "./FollowerGenerator.scss";

// CONSTANTS
const tableHeaders = ["D100", "Follower"];
const tableKeys = ["d100", "name"];
const d100Image = {
  src: '/javascript/src/assets/d100.png'
  // altText: 'A set of d100s'
};

// To do: add this to global constants file, figure out best practices
const baseUrl = 'http://localhost:3000/api/v1/followers_table'

const FollowerGenerator = () => {
  const [followerTableData, setFollowerTableData] = useState([]);
  const [playerClasses, setPlayerClasses] = useState([]);
  const [currentPlayerClassId, setCurrentPlayerClassId] = useState(-1);
  const [followerRoll, setFollowerRoll] = useState(-1);
  const [selectedFollower, setSelectedFollower] = useState({});
  const [followerTable, setFollowerTable] = useState(null);
  const [followerDetails, setFollowerDetails] = useState(null);

  // Fetch player classes for dropdown
  useEffect(() => {
    const url = `${baseUrl}/player_classes`;
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Could not retrieve player classes");
      })
      .then((res) => {
        setPlayerClasses(res.player_classes);
      })
  }, []);

  // Fetch follower table for selected class
  useEffect(() => {
    if (currentPlayerClassId > -1) {
      const url = `${baseUrl}/show/${currentPlayerClassId}`;
      fetch(url)
        .then((res) => {
          if (res.ok) {
            return res.json();
          }
          throw new Error("Could not find followers table");
        })
        .then((res) => {
          setFollowerTableData(res.follower_table);
        });
    }
  }, [currentPlayerClassId]);

  // Set follower on a new roll
  useEffect(() => {
    if (followerRoll >= 0){
      const newFollower = followerTableData.find(follower => {
        return followerRoll <= follower['max_roll'] && followerRoll >= follower['min_roll'];
      }) || {};
      setSelectedFollower(newFollower);
    }
  }, [followerRoll]);

  const rollFollower = () => {
    // Math.random goes 0-1, and a d100 is 1-100
    setFollowerRoll(Math.floor(Math.random() * 99) + 1);
  }

  // COMPUTED PAGE ELEMENTS
  useEffect(() => {
    const table = currentPlayerClassId > -1 && <StandardTable rows={followerTableData} headers={tableHeaders} keys={tableKeys} />
    setFollowerTable(table);
  }, [currentPlayerClassId, followerTableData]);

  useEffect(() => {
    const details = followerRoll > -1 && <div>
                                              { followerRoll }
                                              { Object.keys(selectedFollower).length ? selectedFollower["name"] : null }
                                            </div>
    setFollowerDetails(details);
  }, [followerRoll, selectedFollower]);

  return (
    <div className="follower-generator page-body">
      <div className="follower-table">
        <StandardDropdown selectId="player-class-select"
                          options={playerClasses}
                          onSelect={setCurrentPlayerClassId}
                          defaultValue="Select player class" />
        { followerTable }
      </div>
      <div className="roll-follower">
        <StandardButton image={ d100Image } onClick={ rollFollower } />
      </div>
      { followerDetails }
    </div>
  );
};

export default FollowerGenerator;
