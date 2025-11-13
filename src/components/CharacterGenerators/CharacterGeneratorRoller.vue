<template>
  <div class="character-generator-roller">
    <h1>
      <span>Character Roller</span>
      <span class="system-name">{{ props.gameSystemName }}</span>
    </h1>
    <div v-if="props.loading || !props.dropdownOptions?.value">Loading...</div>
    <div class="roller-options" v-else>
      <StandardDropdown placeholderText="Name Style"
                        :options="props.dropdownOptions.value.nameStyles"
                        selectId="char-style-dropdown"
                        @select="e => $emit('setNameStyle', e)" />
      <StandardDropdown :disabled="!props.dropdownOptions.value.ancestries?.length"
                        placeholderText="Ancestry"
                        :options="props.dropdownOptions.value.ancestries"
                        selectId="char-ancestry-dropdown"
                        @select="e => $emit('setAncestry', e)" />
      <StandardDropdown placeholderText="Class"
                        :options="props.dropdownOptions.value.characterClasses"
                        selectId="char-class-dropdown"
                        @select="e => $emit('setClass', e)" />
      <StandardDropdown placeholderText="Background"
                        :options="props.dropdownOptions.value.backgrounds"
                        selectId="char-class-dropdown"
                        @select="e => $emit('setBackground', e)" />
      <StandardDropdown placeholderText="Lineages"
                        :options="props.generatorDropdownOptions.lineages"
                        selectId="char-lineage-dropdown"
                        @select="e => $emit('setLineage', e)"
                        class="lineage-dropdown" />
      <StandardDropdown placeholderText="Subclass"
                        :options="props.generatorDropdownOptions.characterSubclasses"
                        selectId="char-subclass-dropdown"
                        @select="e => $emit('setSubclass', e)"
                        class="subclasses-dropdown" />
      <StandardDropdown :disabled="!props.dropdownOptions.value.appearances?.length"
                        placeholderText="Appearance"
                        :options="props.dropdownOptions.value.appearances"
                        selectId="char-appearances-dropdown"
                        @select="e => $emit('setAppearance', e)"
                        class="appearances-dropdown" />
    </div>
    <div class="footer">
      <StandardButton @click="$emit('rollCharacter')">
        <img src="@/assets/d100.png" alt="Roll a character" />
      </StandardButton>
    </div>
  </div>
</template>

<script setup>
import StandardButton from "../StandardComponents/StandardButton/StandardButton";
import StandardDropdown from "../StandardComponents/StandardDropdown/StandardDropdown";
import "./CharacterGeneratorRoller.scss";

const props = defineProps({
  gameSystemName: String,
  loading: Boolean,
  dropdownOptions: Object,
  generatorDropdownOptions: Object
});
</script>
