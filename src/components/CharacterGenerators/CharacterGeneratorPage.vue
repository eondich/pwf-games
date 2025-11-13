<template>
  <div class="character-generator-page">
    <CharacterGeneratorRoller :gameSystemName="gameSystem.value?.name"
                                 :loading="loading"
                                 :dropdownOptions="dropdownOptions"
                                 :generatorDropdownOptions="generatorDropdownOptions"
                                 @rollCharacter="rollNewCharacter()"
                                 @setNameStyle="e => generatorSelectedOptions.nameStyle = e"
                                 @setAncestry="e => selectAncestry(e)" 
                                 @setClass="e => selectCharacterClass(e)" 
                                 @setBackground="e => generatorSelectedOptions.background = e" 
                                 @setLineage="e => generatorSelectedOptions.lineage = e" 
                                 @setSubclass="e => generatorSelectedOptions.characterSubclass = e" 
                                 @setAppearance="e => generatorSelectedOptions.appearance = e" />
    <CharacterCard :dropdownOptions="dropdownOptions"
                      :cardDropdownOptions="cardDropdownOptions"
                      :generatorSelectedOptions="generatorSelectedOptions"
                      :selectedOptions="cardSelectedOptions"
                      :loading="loading" />
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

import CharacterGeneratorRoller from './CharacterGeneratorRoller.vue';
import CharacterCard from '../Cards/CharacterCard.vue';

const props = defineProps({
  gameSystemKey: String
});

const loading = ref(true);
const baseUrl = 'http://localhost:3000/api/v1/character_generator';
const gameSystem = reactive({});
const dropdownOptions = reactive({});

// Move into api file?
function fetchBaseData () {
  fetch(`${baseUrl}/base_data/${gameSystem.value.id}`, {
    method: 'get'
  }).then((res) => {
    return res.json();
  }).then((res) => {
    dropdownOptions.value = {
      ancestries: res.ancestries || [],
      characterClasses: res.player_classes || [],
      nameStyles: res.name_styles || [],
      backgrounds: res.backgrounds || [],
      appearances: res.appearances || []
    }
  });
  loading.value = false;
}

fetch(`${baseUrl}/game_system/${props.gameSystemKey}`, {
  method: 'get'
}).then((res) => {
  return res.json();
}).then((res) => {
  gameSystem.value = res.game_system;
  fetchBaseData();
});

const baseOptions = {
  ancestry: null,
  appearance: null,
  background: null,
  characterClass: null,
  characterName: null
};
const subOptions = {
  lineage: null,
  characterSubclass: null
};
const generatorSpecific = {
  nameStyle: null
};

// Generator data
const generatorSelectedOptions = reactive({
  ...baseOptions,
  ...subOptions,
  ...generatorSpecific
});

const generatorDropdownOptions = reactive({
  characterSubclasses: [],
  lineages: []
});

// Card data
const cardSelectedOptions = reactive({
  ...baseOptions,
  ...subOptions
});

const cardDropdownOptions = reactive({
  characterSubclasses: [],
  lineages: []
});

// Fetch data as selections change
function fetchLineages (ancestryId) {
  return fetch(`${baseUrl}/lineages/${gameSystem.value.id}/${ancestryId}`, {
    method: 'get'
  }).then((res) => {
    return res.json();
  }).then((res) => {
    return res.lineages;
  });
}

function fetchCharacterSubclasses (characterClassId) {
  return fetch(`${baseUrl}/player_subclasses/${gameSystem.value.id}/${characterClassId}`, {
    method: 'get'
  }).then((res) => {
    return res.json();
  }).then((res) => {
    return res.player_subclasses;
  });
}

// Update data
function selectAncestry (newAncestry) {
  generatorSelectedOptions.ancestry = newAncestry;
  fetchLineages(newAncestry).then(res => {
    generatorDropdownOptions.lineages = res || [];
  });
}

function selectCharacterClass (newCharacterClass) {
  generatorSelectedOptions.characterClass = newCharacterClass;
  fetchCharacterSubclasses(newCharacterClass).then(res => {
    generatorDropdownOptions.characterSubclasses = res;
  });
}

// Character generation
function generateAncestry () {
  const ancestryIndex = Math.floor(Math.random() * dropdownOptions.value.ancestries.length);
  const ancestryId = dropdownOptions.value.ancestries[ancestryIndex].id;
  generateLineage(ancestryId);
  return ancestryId;
}

function generateLineage (ancestryId) {
  if (generatorSelectedOptions.lineage) {
    cardSelectedOptions.lineage = generatorSelectedOptions.lineage;
  } else if (generatorDropdownOptions.lineages.length) {
    cardDropdownOptions.lineages = generatorDropdownOptions.lineages;
    const lineageIndex = Math.floor(Math.random() * cardDropdownOptions.lineages.length);
    cardSelectedOptions.lineage = cardDropdownOptions.lineages[lineageIndex];
  } else {
    fetchLineages(ancestryId).then(res => {
      cardDropdownOptions.lineages = res;
      const lineageIndex = Math.floor(Math.random() * cardDropdownOptions.lineages.length);
      cardSelectedOptions.lineage = cardDropdownOptions.lineages[lineageIndex];
    });
  }
}

function generateAppearance () {
  const appearanceIndex = Math.floor(Math.random() * (dropdownOptions.value.appearances.length));
  return dropdownOptions.value.appearances[appearanceIndex].id;
}

function generateBackground () {
  const backgroundIndex = Math.floor(Math.random() * (dropdownOptions.value.backgrounds.length));
  return dropdownOptions.value.backgrounds[backgroundIndex].id;
}

function generateCharacterClass () {
  const characterClassIndex = Math.floor(Math.random() * dropdownOptions.value.characterClasses.length);
  const characterClassId = dropdownOptions.value.characterClasses[characterClassIndex].id;
  generateCharacterSubclass(characterClassId);
  return characterClassId;
}

function generateCharacterSubclass (characterClassId) {
  if (generatorSelectedOptions.characterSubclass) {
    cardSelectedOptions.characterSubclass = generatorSelectedOptions.characterSubclass;
  } else if (generatorDropdownOptions.characterSubclasses.length) {
    cardDropdownOptions.characterSubclasses = generatorDropdownOptions.characterSubclasses;
    const subclassIndex = Math.floor(Math.random() * cardDropdownOptions.characterSubclasses.length);
    cardSelectedOptions.characterSubclass = cardDropdownOptions.characterSubclasses[subclassIndex];
  } else {
    fetchCharacterSubclasses(characterClassId).then(res => {
      cardDropdownOptions.characterSubclasses = res;
      const subclassIndex = Math.floor(Math.random() * cardDropdownOptions.characterSubclasses.length);
      cardSelectedOptions.characterSubclass = cardDropdownOptions.characterSubclasses[subclassIndex];
    });
  }
}

function generateCharacterName (selectedStyleId) {
  let url = `${baseUrl}/character_name/${gameSystem.value.id}/style/`;
  if (!isNaN(parseInt(selectedStyleId))) {
    url = url.concat(selectedStyleId);
  } else {
    const nameStyleIndex = Math.floor(Math.random() * dropdownOptions.value.nameStyles.length);
    url = url.concat(dropdownOptions.value.nameStyles[nameStyleIndex].id);
  }

  return fetch(url, {
    method: 'get'
  }).then((res) => {
    return res.json();
  }).then((res) => {
    cardSelectedOptions.characterName = res.character_name;
  });
}

function rollNewCharacter () {
  Object.keys(baseOptions).forEach(key => {
    if (generatorSelectedOptions[key]) {
      cardSelectedOptions[key] = generatorSelectedOptions[key];

      // TODO: Abstract out keys
      if (key === 'ancestry') {
        generateLineage(generatorSelectedOptions[key].id);
      } else if (key === 'characterClass') {
        generateCharacterSubclass(generatorSelectedOptions[key].id);
      }
    }
    else {
      switch (key) {
        case 'ancestry':
          cardSelectedOptions[key] = generateAncestry();
          break;
        case 'appearance':
          cardSelectedOptions[key] = generateAppearance();
          break;
        case 'background':
          cardSelectedOptions[key] = generateBackground();
          break;
        case 'characterClass':
          cardSelectedOptions[key] = generateCharacterClass();
          break;
        default:
          break;
      }
    }
  });

  generateCharacterName(generatorSelectedOptions.nameStyle);
}
</script>

<style scoped lang="scss">
@import "./CharacterGeneratorPage.scss";
</style>
