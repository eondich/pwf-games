<template>
  <span class="standard-textbox">
    <label v-if="props.label" :for="props.id">{{ props.label }}</label>
    <input type="text" :id="props.id"
                       :name="props.id"
                       :placeholder="props.placeholder"
                       :defaultValue="props.defaultValue" />
  </span>
</template>

<script setup>
const props = defineProps({
  id: {
    type: String,
    default: ''
  },
  defaultValue: {
    type: String,
    default: ''
  },
  label: {
    type: String,
    default: ''
  },
  placeholder: {
    type: String,
    default: ''
  },
});
</script>

<style scoped lang="scss">
@import "./StandardTextbox.scss";
</style>