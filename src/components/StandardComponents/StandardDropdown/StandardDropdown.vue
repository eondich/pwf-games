<template>
  <div class="standard-dropdown">
    <label v-if="props.label"
           :for="props.selectId"
           :class="`${props.selectId}-label`">{{ props.label }}</label>
    <select :name="props.selectId"
            :id="props.selectId"
            :class="selectClasses"
            :value="selectedValue"
            :disabled="currentlyDisabled"
            @change="e => {
              $emit('select', e.target.value);
              // I am sure there's a better way to do this, and I'll come back and figure it out when I do some 
              // SERIOUS code cleanup after getting HMTW sorted (ah, the joys of doing a personal project that
              // spans years)
              selectedValue = e.target.value;
            }">
      <option v-if="props.placeholderText"
              value=""
              :key="`${props.selectId}-default`">{{ props.placeholderText }}</option>
      <option v-for="option in options"
              :value="option['id']"
              :key="`${props.selectId}-${option['id']}`">{{ option['name'] }}</option>
    </select>
  </div>
</template>

<script setup>
/* eslint-disable */
import { computed, ref, watch } from 'vue';

const props = defineProps({
    defaultSelectedValue: {
      type: String,
      default: ''
    },
    disabled: {
      type: Boolean,
      default: false
    },
    placeholderText: {
      type: String,
      default: ''
    },
    label: {
      type: String,
      default: ''
    },
    options: {
      type: Array
    },
    selectId: {
      type: String,
      default: ''
    }
  });

  let selectedValue = ref(props.defaultSelectedValue);

  // Computed values
  let currentlyDisabled = computed(() => {
    return props.disabled || !props.options || props.options.length === 0;
  });

  let selectClasses = computed(() => {
    let classes = props.selectId
    if (currentlyDisabled.value) {
      classes = classes.concat(' disabled');
    }
    if (!selectedValue.value) {
      classes = classes.concat(' placeholder');
    }
    return classes;
  });

  watch(props, () => {
    selectedValue.value = props.defaultSelectedValue;
  });
</script>

<style scoped lang="scss">
@import "./StandardDropdown.scss";
</style>