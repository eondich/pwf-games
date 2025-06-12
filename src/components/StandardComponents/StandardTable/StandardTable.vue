<template>
  <table class="standard-table">
    <tr>
      <th :v-for="header in props.headers" 
          :key="headerKeys[header]">{{ header }}</th>
    </tr>
    <tr :v-for="row in props.rows"
        :key="`row-${row.id}`">
        <td :v-for="header in headers"
            :key="`${headerKeys[header]}-${row.id}`">
            {{ row[headerKeys[header]] }}
        </td>
    </tr>
  </table>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  rows: {
    type: Array,
    default: []
  },
  headers: {
    type: Array,
    default: []
  }
});

const headerKeys = computed(() => {
  const headersMap = {}
  return headers.reduce(header => {
    headersMap[header] = header.toLowerCase().replace(" ", "");
    return headersMap;
  }, headersMap);
});
</script>

<style scoped lang="scss">
@import './StandardTable.scss';
</style>