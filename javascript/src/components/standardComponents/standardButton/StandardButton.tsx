import React from "react";
import "./StandardButton.scss";

interface ButtonProps {
  label?: string,
  image?: Object,
  loading?: boolean,
  onClick: Function
}

const StandardButton = (props: ButtonProps) => {
  return (
    <>
      <button className="standard-button" onClick={ props.onClick }>
        { props.image && <img src='d100.png' alt={props.image['altText']} /> }
        { props.label }
      </button>
    </>
  )
}

export default StandardButton
