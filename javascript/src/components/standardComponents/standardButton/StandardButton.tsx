import React from "react";
import "./StandardButton.scss";

interface ButtonProps {
  label: string,
  loading?: boolean,
  onClick: Function
}

const StandardButton = (props: ButtonProps) => {
  return (
    <>
      <button className="standard-button" onClick={ props.onClick }>{ props.label }</button>
    </>
  )
}

export default StandardButton
