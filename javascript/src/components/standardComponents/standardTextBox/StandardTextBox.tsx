import React, { useEffect, useState } from "react";

import "./StandardTextbox.scss";

interface StandardTextboxProps {
  id: string,
  defaultValue?: string,
  label?: string,
  placeholder?: string
}

export default function StandardTextbox (props: StandardTextboxProps) {
  return (
    <span className="standard-textbox">
      { props.label && <label for={ props.id }>{ props.label }</label> }
      <input type="text" id={ props.id }
                         name={ props.id }
                         placeholder={ props.placeholder }
                         defaultValue={ props.defaultValue } />
    </span>
  )
}