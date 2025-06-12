<template>
  <CharacterGeneratorPage :gameSystemKey="gameSystem" />
</template>

<script>
import CharacterGeneratorPage from '../CharacterGeneratorPage.vue';

export default {
  components: {
    CharacterGeneratorPage
  },
  data () {
    return {
      gameSystem: 'dnd5e2024'
    }
  }
}
</script>
