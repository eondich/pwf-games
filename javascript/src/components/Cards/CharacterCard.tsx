import React, { useEffect, useState } from "react";

import StandardDropdown from "../standardComponents/standardDropdown/StandardDropdown";
import StandardTextbox from "../standardComponents/standardTextBox/StandardTextBox";

import "./CharacterCard.scss";

// Keeping this super simple for now, character sheet design
// is a big project but I want some basic functionality
// running so we can use this in our game

// The actual character data should be generated elsewhere, since
// different pages will have different rules and will be drawing
// from different data sets

interface CharacterCardProps {
  availableAncestries: Object[],
  availableClasses: Object[],
  presetCharName?: string,
  selectedAncestry?: string,
  selectedClass?: string
}

export default function CharacterCard (props: CharacterCardProps) {
  return (
    <div className="character-card">
      <StandardTextbox placeholder="Name"
                       id="char-name"
                       defaultValue={props.presetCharName} />
      <StandardDropdown placeholderText="Ancestry"
                        options={props.availableAncestries}
                        selectId="char-ancestry-dropdown"
                        onSelect={() => {}}
                        defaultSelectedValue={props.selectedAncestry} />
      <StandardDropdown placeholderText="Class"
                        options={props.availableClasses}
                        selectId="char-class-dropdown"
                        onSelect={() => {}}
                        defaultSelectedValue={props.selectedClass} />
    </div>
  )
}