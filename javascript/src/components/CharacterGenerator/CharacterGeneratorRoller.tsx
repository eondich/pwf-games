import React, { useEffect, useState } from "react";

import StandardButton from "../standardComponents/standardButton/StandardButton";
import StandardDropdown from "../standardComponents/standardDropdown/StandardDropdown";

import "./CharacterGeneratorRoller.scss";
import { default as d100 } from "../../assets/d100.png";

interface CharacterGeneratorRollerProps {
  availableAncestries: Object[],
  availableClasses: Object[],
  availableGenders: Object[],
  availableSources: Object[],
  initCharAncestry?: string,
  initCharClass?: string,
  onRoll: Function,
  onSelectAncestry: Function,
  onSelectClass: Function,
  onSelectGender: Function,
  onSelectSource: Function
}

export default function CharacterGeneratorRoller (props: CharacterGeneratorRollerProps) {
  return (
    <div className="character-generator-roller">
      <h1>Character Roller</h1>
      <div className="base-options roller-options">
        <StandardDropdown placeholderText="Source"
                          selectId="source-material-dropdown"
                          options={props.availableSources}
                          onSelect={props.onSelectSource} />
        <StandardDropdown placeholderText="Ancestry"
                          options={props.availableAncestries}
                          selectId="char-ancestry-dropdown"
                          onSelect={props.onSelectAncestry}
                          defaultSelectedValue={props.initCharAncestry} />
        <StandardDropdown placeholderText="Class"
                          options={props.availableClasses}
                          selectId="char-class-dropdown"
                          onSelect={props.onSelectClass}
                          defaultSelectedValue={props.initCharClass} />
        <StandardDropdown placeholderText="Name Gender"
                          options={props.availableGenders}
                          selectId="char-gender-dropdown"
                          onSelect={props.onSelectGender}/>
      </div>
      <div className="footer">
        <StandardButton onClick={props.onRoll}>
          <img src={d100} alt="Roll a character" />
        </StandardButton>
      </div>
    </div>
  )
}