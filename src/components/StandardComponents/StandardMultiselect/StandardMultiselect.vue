<template>
  <div class="standard-multiselect">
    <button :v-for="option in selectOptions"
            :key="`option-${option.id}`"
            @click="toggleSelect(option)">
    </button>
  </div>
</template>

<script>
export default {
  props: {
    selectOptions: {
      type: Array,
      default: () => []
    }
  }
}

// function toggleSelect(option) {

// }
</script>

<style scoped lang="scss">
@import './StandardMultiselect.scss';
</style>