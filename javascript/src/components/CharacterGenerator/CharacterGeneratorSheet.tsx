import React, { useEffect, useState } from "react";

import StandardDropdown from "../standardComponents/standardDropdown/StandardDropdown";

// Keeping this super simple for now, character sheet design
// is a big project but I want some basic functionality
// running so we can use this in our game

// The actual character data should be generated elsewhere, since
// different pages will have different rules and will be drawing
// from different data sets

interface CharacterGeneratorSheetProps {
  availableAncestries: Object[],
  availableClasses: Object[],
  initCharAncestry?: number,
  initCharClass?: number,
  initCharName?: string,
  onSelectAncestry: Function,
  onSelectClass: Function
}

export default function CharacterGeneratorSheet (props: CharacterGeneratorSheetProps) {
  return (
    <div className="follower-generator-sheet">
      <div className="char-name">{props.initCharName}</div>
      <StandardDropdown defaultValue="Ancestry"
                        options={props.availableAncestries}
                        selectId="char-ancestry-dropdown"
                        onSelect={props.onSelectAncestry}
                        defaultSelectedValue={props.initCharAncestry} />
      <StandardDropdown defaultValue="Class"
                        options={props.availableClasses}
                        selectId="char-ancestry-dropdown"
                        onSelect={props.onSelectClass}
                        defaultSelectedValue={props.initCharClass} />
    </div>
  )
}