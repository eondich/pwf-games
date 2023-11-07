import React, { useEffect, useState } from "react";

import StandardDropdown from "../standardComponents/standardDropdown/StandardDropdown";

// Keeping this super simple for now, character sheet design
// is a big project but I want some basic functionality
// running so we can use this in our game

// The actual character data should be generated elsewhere, since
// different pages will have different rules and will be drawing
// from different data sets

interface CharacterCardProps {
  availableAncestries: Object[],
  availableClasses: Object[],
  initCharName?: string,
  selectedAncestry?: number,
  selectedClass?: number
}

export default function CharacterCard (props: CharacterCardProps) {
  return (
    <div className="character-card">
      <div className="char-name">{props.initCharName}</div>
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