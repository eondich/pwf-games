import React, { Children } from "react";
import "./StandardButton.scss";

interface ButtonProps {
  children?: Object,
  loading?: boolean,
  onClick: Function
}

const StandardButton = (props: ButtonProps) => {
  return (
    <>
      <button className="standard-button"
              onClick={ props.onClick }>
        { props.children }
      </button>
    </>
  )
}

export default StandardButton
