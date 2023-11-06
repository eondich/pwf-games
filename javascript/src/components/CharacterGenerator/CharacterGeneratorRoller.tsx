import React, { useEffect, useState } from "react";

import StandardDropdown from "../standardComponents/standardDropdown/StandardDropdown";

interface CharacterGeneratorRollerProps {
  availableSources?: Object[],
  onSelectSource: Function
}

export default function CharacterGeneratorRoller (props: CharacterGeneratorRollerProps) {
  return (
    <div className="character-generator-roller">
      <StandardDropdown defaultValue="Source"
                        selectId="source-material-dropdown"
                        options={props.availableSources}
                        onSelect={props.onSelectSource} />
    </div>
  )
}