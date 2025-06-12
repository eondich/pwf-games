<template>
  <div class="app">
    <app-header />
    <RouterView />
  </div>
</template>

<script>
import { RouterView } from "vue-router";
import AppHeader from "../AppHeader/AppHeader"

export default {
  components: {
    AppHeader,
    RouterView
  }
}
</script>

<style scoped lang="scss">
@import "./App.scss";
</style>
