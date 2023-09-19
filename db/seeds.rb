# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Ancestries
["human", "halfling", "elf", "tiefling", "half-elf", "dwarf", "gnome", "dragonborn", "hobgoblin", "gnoll", "orc", "lizardfolk"].each do |a|
  Ancestry.create(name: a)
end

# Player classes and skins for those classes
class_retainer_map = {
  "barbarian": ["reaver", "spirit warden"],
  "bard": ["loremaster", "troubadour-warrior"],
  "cleric": ["curate", "exorcist", "healer", "shadow priest", "stormspeaker", "warden", "battle priest"],
  "druid": ["mystic", "skinwalker"],
  "fighter": ["knight-sorcerer", "swordmaster", "warlord"],
  "monk": ["acolyte of the way", "acolyte of darkness", "elemental acolyte"],
  "paladin": ["cavalier", "justicar", "knight of the green order"],
  "ranger": ["beast lord", "tracker"],
  "rogue": ["executioner", "guild adept", "cutpurse"],
  "sorcerer": ["thaumaturgist", "chaos mage"],
  "warlock": ["alienist", "diabolist", "exarch"],
  "wizard": ["conjurer", "enchanter", "evoker", "illusionist", "necromancer", "seer", "shaper", "theurgist"]
}
retainer_subclass_map = {
  "reaver": "berserker",
  "spirit warden": "totem warrior",
  "loremaster": "lore",
  "troubadour-warrior": "valor",
  "curate": "knowledge",
  "exorcist": "light",
  "healer": "life",
  "shadow priest": "trickery",
  "stormspeaker": "tempest",
  "warden": "nature",
  "battle priest": "war",
  "mystic": "land",
  "skinwalker": "moon",
  "knight-sorcerer": "eldritch knight",
  "swordmaster": "battle master",
  "warlord": "champion",
  "acolyte of the way": "open hand",
  "acolyte of darkness": "shadow",
  "elemental acolyte": "four elements",
  "cavalier": "devotion",
  "justicar": "vengeance",
  "knight of the green order": "ancients",
  "beast lord": "beastmaster",
  "tracker": "hunter",
  "executioner": "assassin",
  "guild adept": "arcane trickster",
  "cutpurse": "thief",
  "thaumaturgist": "draconic bloodline",
  "chaos mage": "wild magic",
  "alienist": "great old one",
  "diabolist": "fiend",
  "exarch": "archfey",
  "conjurer": "conjuration",
  "enchanter": "enchantment",
  "evoker": "evocation",
  "illusionist": "illusion",
  "necromancer": "necromancy",
  "seer": "divination",
  "shaper": "transmutation",
  "theurgist": "abjuration"
}
class_retainer_map.keys.each do |class_name|
  pclass = PlayerClass.create(name: class_name)
  class_retainer_map[class_name].each do |rclass|
    psubclass = PlayerSubclass.create(name: retainer_subclass_map[rclass.to_sym], player_class_id: pclass.id)
    RetainerClass.create(name: rclass, player_subclass: psubclass)
  end
end

# Artisans
["alchemist", "blacksmith", "captain", "carpenter", "farmer", "mason", "miner", "sage", "scribe", "spy", "tailor"].each do |a|
  Artisan.create(name: a)
end

# Ambassadors
Ancestry.all.each do |a|
  Ambassador.create(ancestry_id: a.id)
end

# Military units needed for test table
unit1 = MilitaryUnitFollower.create(experience: :elite, equipment: :light, unit_type: :infantry)
unit2 = MilitaryUnitFollower.create(experience: :veteran, equipment: :medium, unit_type: :cavalry)
unit3 = MilitaryUnitFollower.create(experience: :regular, equipment: :light, unit_type: :flying)

# Generic special ally to use on tables
special_ally = SpecialAlly.create(name: "roll on the special allies table")

# Populate barbarian retainer table
barbarian_id = PlayerClass.find_by(name: "barbarian").id
FollowerRoll.create(min_roll: 1, max_roll: 6, follower: unit1, follower_level: 2, player_class_id: barbarian_id)
FollowerRoll.create(min_roll: 7, max_roll: 12, follower: unit2, follower_level: 1, player_class_id: barbarian_id)
FollowerRoll.create(min_roll: 13, max_roll: 15, follower: unit3, follower_level: 1, player_class_id: barbarian_id)
exarch = RetainerClass.find_by(name: "exarch")
FollowerRoll.create(min_roll: 16, max_roll: 17, follower: exarch, follower_level: 3, player_class_id: barbarian_id)
warlord = RetainerClass.find_by(name: "warlord")
FollowerRoll.create(min_roll: 18, max_roll: 24, follower: warlord, follower_level: 3, player_class_id: barbarian_id)
skinwalker = RetainerClass.find_by(name: "skinwalker")
FollowerRoll.create(min_roll: 25, max_roll: 29, follower: skinwalker, follower_level: 3, player_class_id: barbarian_id)
beast_lord = RetainerClass.find_by(name: "beast lord")
FollowerRoll.create(min_roll: 30, max_roll: 34, follower: beast_lord, follower_level: 3, player_class_id: barbarian_id)
necromancer = RetainerClass.find_by(name: "necromancer")
FollowerRoll.create(min_roll: 35, max_roll: 41, follower: necromancer, follower_level: 3, player_class_id: barbarian_id)
swordmaster = RetainerClass.find_by(name: "swordmaster")
FollowerRoll.create(min_roll: 42, max_roll: 47, follower: swordmaster, follower_level: 5, player_class_id: barbarian_id)
diabolist = RetainerClass.find_by(name: "diabolist")
FollowerRoll.create(min_roll: 48, max_roll: 52, follower: diabolist, follower_level: 5, player_class_id: barbarian_id)
tracker = RetainerClass.find_by(name: "tracker")
FollowerRoll.create(min_roll: 53, max_roll: 55, follower: tracker, follower_level: 7, player_class_id: barbarian_id)
artisan = Artisan.find_by(name: "blacksmith")
FollowerRoll.create(min_roll: 56, max_roll: 60, follower: artisan, player_class_id: barbarian_id)
artisan = Artisan.find_by(name: "miner")
FollowerRoll.create(min_roll: 61, max_roll: 65, follower: artisan, player_class_id: barbarian_id)
artisan = Artisan.find_by(name: "sage")
FollowerRoll.create(min_roll: 66, max_roll: 70, follower: artisan, player_class_id: barbarian_id)
ambassador_ancestry = Ancestry.find_by(name: "hobgoblin")
ambassador = Ambassador.find_by(ancestry_id: ambassador_ancestry)
FollowerRoll.create(min_roll: 71, max_roll: 75, follower: ambassador, player_class_id: barbarian_id)
ambassador_ancestry = Ancestry.find_by(name: "gnoll")
ambassador = Ambassador.find_by(ancestry_id: ambassador_ancestry)
FollowerRoll.create(min_roll: 76, max_roll: 80, follower: ambassador, player_class_id: barbarian_id)
FollowerRoll.create(min_roll: 81, max_roll: 100, follower: special_ally, player_class_id: barbarian_id)
