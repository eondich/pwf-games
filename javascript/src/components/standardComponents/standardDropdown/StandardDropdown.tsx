import React from "react";
import "./StandardDropdown.scss";

interface DropdownProps {
  defaultValue?: string,
  label?: string,
  onSelect: Function,
  options: Object[],
  selectId: string
}

function getOptions(allOptions, defaultValue, selectId) {
  const optionArray = allOptions.map(option => {
    return <option value={option['value']} key={`${selectId}-${option['value']}`}>{ option['name'] }</option>
  });
  if (defaultValue) {
    optionArray.unshift(<option value="" key={`${selectId}-default`} className="default">{defaultValue}</option>);
  }
  return optionArray;
}

function StandardDropdown (props: DropdownProps) {
  return (
    <div className="standard-dropdown">
      {
        (props.label && <label htmlFor={props.selectId} className={`${props.selectId}-label`}>{ props.label }</label>)
      }
      {
        <select name={props.selectId} id={props.selectId} className={props.selectId} onChange={(e) => { props.onSelect(e.target.value) }}>
          { getOptions(props.options, props.defaultValue, props.selectId) }
        </select>
      }
    </ div>
  )
};

export default StandardDropdown;
