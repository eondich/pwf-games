import React, { useEffect, useState } from "react";
import "./StandardDropdown.scss";

interface DropdownProps {
  defaultSelectedValue?: number,
  disabled?: boolean,
  placeholderText?: string,
  label?: string,
  onSelect: Function,
  options: Object[],
  selectId: string
}

function StandardDropdown (props: DropdownProps) {
  const [currentlyDisabled, setCurrentlyDisabled] = useState(false);
  const [selectClasses, setSelectClasses] = useState('');
  const [selectedValue, setSelectedValue] = useState('');

  // Set currentlyDisabled
  useEffect(() => {
    setCurrentlyDisabled(props.disabled || props.options.length === 0);
  }, [props.disabled, props.options]);

  // Set selectClasses
  useEffect(() => {
    let classes = props.selectId
    if (currentlyDisabled) {
      classes = classes.concat(`, disabled`);
    }
    if (!selectedValue) {
      classes = classes.concat(`, default`);
    }
    setSelectClasses(classes);
  }, [props.selectId, currentlyDisabled, selectedValue]);

  // Set selectedValue to default
  useEffect(() => {
    setSelectedValue(props.defaultSelectedValue);
  }, [props.defaultSelectedValue]);

  function getOptions(allOptions, placeholderText, selectId) {
    const optionArray = allOptions.map(option => {
      return <option value={option['id']} key={`${selectId}-${option['id']}`}>{ option['name'] }</option>
    });
    if (placeholderText) {
      optionArray.unshift(<option value='' disabled key={`${selectId}-default`}>{placeholderText}</option>);
    }
    return optionArray;
  }

  function selectOption(option) {
    setSelectedValue(option);
    props.onSelect(option);
  } 
  
  return (
    <div className="standard-dropdown">
      {
        (props.label && <label htmlFor={props.selectId} className={`${props.selectId}-label`}>{ props.label }</label>)
      }
      {
        <select name={ props.selectId }
                id={ props.selectId }
                className={ selectClasses }
                onChange={(e) => { selectOption(e.target.value) }}
                value={ selectedValue }
                disabled={ currentlyDisabled }>
          { getOptions(props.options, props.placeholderText, props.selectId) }
        </select>
      }
    </ div>
  )
};

export default StandardDropdown;
