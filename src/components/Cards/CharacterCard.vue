<template>
  <div class="character-card">
    <div v-if="props.loading || !dropdownOptions.value">Loading...</div>
    <div v-else class="character-options">
      <StandardTextbox placeholder="Name"
                       id="char-name"
                       :defaultValue="selectedOptions.characterName"
                       label="Name" />
      <StandardDropdown :disabled="!props.dropdownOptions.value.ancestries?.length"
                        placeholderText="Ancestry"
                        :options="props.dropdownOptions.value.ancestries"
                        selectId="char-ancestry-dropdown"
                        :defaultSelectedValue="props.selectedOptions?.ancestry"
                        @select="selectAncestry(e)"
                        label="Ancestry" />
      <StandardDropdown placeholderText="Class"
                        :options="props.dropdownOptions.value.characterClasses"
                        selectId="char-class-dropdown"
                        :defaultSelectedValue="props.selectedOptions?.characterClass"
                        @select="selectClass(e)"
                        label="Class" />
      <StandardDropdown placeholderText="Background"
                        :options="props.dropdownOptions.value.backgrounds"
                        selectId="char-background-dropdown"
                        :defaultSelectedValue="props.selectedOptions?.background"
                        label="Background" />
      <StandardDropdown :disabled="!props.cardDropdownOptions.lineages?.length && !!props.selectedOptions?.ancestry"
                        placeholderText="Lineage"
                        :options="props.cardDropdownOptions.lineages"
                        selectId="char-lineage-dropdown"
                        :defaultSelectedValue="props.selectedOptions?.lineage?.id"
                        class="character-lineage"
                        label="Lineage" />
      <StandardDropdown :disabled="!props.cardDropdownOptions.characterSubclasses?.length && !!props.selectedOptions?.characterClass"
                        placeholderText="Subclass"
                        :options="props.cardDropdownOptions.characterSubclasses"
                        selectId="char-subclass-dropdown"
                        :defaultSelectedValue="props.selectedOptions?.characterSubclass?.id"
                        class="character-subclass"
                        label="Subclass" />
      <StandardDropdown :disabled="!props.dropdownOptions.value?.appearances?.length"
                        placeholderText="Appearance"
                        :options="props.dropdownOptions.value.appearances"
                        selectId="char-appearance-dropdown"
                        :defaultSelectedValue="props.selectedOptions?.appearance"
                        class="character-appearance"
                        label="Appearance" />
    </div>
  </div>
</template>

<script setup>
import StandardTextbox from "../StandardComponents/StandardTextbox/StandardTextbox";
import StandardDropdown from "../StandardComponents/StandardDropdown/StandardDropdown";

const props = defineProps({
  dropdownOptions: Object,
  cardDropdownOptions: Object,
  generatorSelectedOptions: Object,
  selectedOptions: Object,
  loading: Boolean,
});
</script>

<style scoped lang="scss">
@import "./CharacterCard.scss";
</style>