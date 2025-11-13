# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Add dnd as a system
# dnd2014 = GameSystem.create(name: "dungeons & dragons (2014)", allows_multiclassing: true, key: "dnd5e2014")
dnd2024 = GameSystem.create(name: "dungeons & dragons (2024)", allows_multiclassing: true, key: "dnd5e2024")
# pir_borg = GameSystem.create(name: "pirate borg", allows_multiclassing: false)
# dnd2014 = GameSystem.find_by(key: "dnd5e2014")
# dnd2024 = GameSystem.find_by(key: "dnd5e2024")

# Ancestries
lineage_map = {
  "dragonborn": ["black", "blue", "brass", "bronze", "copper", "gold", "green", "red", "silver", "white"],
  "elf": ["drow", "high elf", "wood elf"],
  "gnome": ["forest gnome", "rock gnome"],
  "goliath": ["cloud giant", "fire giant", "frost giant", "hill giant", "stone giant", "storm giant"],
  "tiefling": ["abyssal", "chthonic", "infernal"]
}

["human", "halfling", "elf", "tiefling", "half-elf", "dwarf", "gnome", "dragonborn", "orc"].each do |a|
  ancestry = Ancestry.create(name: a)
  # ancestry.game_systems << dnd2014
  ancestry.game_systems << dnd2024

  a_key = a.to_sym

  if lineage_map[a_key]
    lineage_map[a_key].each do |l|
      Lineage.create(name: l, ancestry: ancestry, game_system: dnd2024)
    end
  end
end

# ["hobgoblin", "gnoll", "lizardfolk"].each do |a|
#   ancestry = Ancestry.create(name: a)
#   ancestry.game_systems << dnd2014
# end

["aasimar", "goliath"].each do |a|
  ancestry = Ancestry.create(name: a)
  ancestry.game_systems << dnd2024
end

# 5e Player classes
subclass_map = {
  "artificer": {
    options: [
      "alchemist",
      "armorer",
      "artillerist",
      "battle smith",
      "cartographer"
    ],
    modifier: nil,
    hit_die: 8
  },
  "barbarian": {
    options: [
      "berserker",
      "wild heart",
      "world tree",
      "zealot"
    ],
    modifier: "path of the",
    modifier_is_prefix: true,
    hit_die: 12
  },
  "bard": {
    options: [
      "glamour",
      "lore",
      "moon",
      "valor"
    ],
    modifier: "college of",
    modifier_is_prefix: true,
    hit_die: 8
  },
  "cleric": {
    options: [
      "life",
      "light",
      "trickery",
      "war"
    ],
    modifier: "domain",
    modifier_is_prefix: false,
    hit_die: 8
  },
  "druid": {
    options: [
      "land",
      "moon",
      "sea",
      "stars"
    ],
    modifier: "circle of",
    modifier_is_prefix: true,
    hit_die: 8
  },
  "fighter": {
    options: [
      "battle master",
      "champion",
      "eldritch knight",
      "psi warrior",
      "purple dragon knight"
    ],
    modifier: nil,
    hit_die: 10
  },
  "monk": {
    options: [
      "mercy",
      "shadow",
      "the elements",
      "the open hand"
    ],
    modifier: "warrior of",
    modifier_is_prefix: true,
    hit_die: 8
  },
  "paladin": {
    options: [
      "devotion",
      "glory",
      "the ancients",
      "the noble genies",
      "vengeance"
    ],
    modifier: "oath of",
    modifier_is_prefix: true,
    hit_die: 10
  },
  "ranger": {
    options: [
      "beast master",
      "fey wanderer",
      "gloom stalker",
      "hunter",
      "winter walker"
    ],
    modifier: nil,
    hit_die: 10
  },
  "rogue": {
    options: [
      "arcane trickster",
      "assassin",
      "scion of the three",
      "soulknife",
      "thief"
    ],
    modifier: nil,
    hit_die: 8
  },
  "sorcerer": {
    options: [
      "aberrant",
      "clockwork",
      "draconic",
      "spellfire",
      "wild magic"
    ],
    modifier: "sorcery",
    modifier_is_prefix: false,
    hit_die: 6
  },
  "warlock": {
    options: [
      "archfey",
      "celestial",
      "fiend",
      "great old one"
    ],
    modifier: "patron",
    modifier_is_prefix: false,
    hit_die: 8
  },
  "wizard": {
    options: [
      "abjurer",
      "bladesinger",
      "diviner",
      "evoker",
      "illusionist"
    ],
    modifier: nil,
    hit_die: 6
  }
}

subclass_map.each_key do |class_name|
  class_details = subclass_map[class_name]
  pclass = PlayerClass.create(name: class_name, name_modifier: class_details[:modifier], name_modifier_is_prefix: class_details[:modifier_is_prefix], hit_die: class_details[:hit_die])
  # pclass.game_systems << dnd2014
  pclass.game_systems << dnd2024
  subclass_map[class_name][:options].each do |subclass|
    subclass = PlayerSubclass.create(name: subclass)
    subclass.game_systems << dnd2024
    subclass.player_class = pclass
    subclass.save!
  end
end

# Pirate Borg classes and subclasses
# ["brute", "rapscallion", "buccaneer", "swashbuckler", "zealot", "sorcerer", "haunted one", "tall tale"].each do |class_name|
#   pclass = PlayerClass.create(name: class_name)
#   pclass.game_systems << pir_borg
# end

# Name styles (5e 2024)
["common", "guttural", "lyrical", "monosyllabic", "sinister", "whimsical"].each do |name_style|
  s = NameStyle.create(style: name_style)
  s.game_systems << dnd2024
end

# Stats
stats = [
  {
    name: "strength",
    abbr: "str"
  },
  {
    name: "dexterity",
    abbr: "dex"
  },
  {
    name: "constitution",
    abbr: "con"
  },
  {
    name: "intelligence",
    abbr: "int"
  },
  {
    name: "wisdom",
    abbr: "wis"
  },
  {
    name: "charisma",
    abbr: "cha"
  },
]

stats.each do |stat_details|
  # CharacterStat.create(name: stat_details[:name], abbreviation: stat_details[:abbr], game_system_id: dnd2014[:id])
  CharacterStat.create(name: stat_details[:name], abbreviation: stat_details[:abbr], game_system_id: dnd2024[:id])
end

# Backgrounds
backgrounds = [
  {
    name: "acolyte",
    stats: [
      "int",
      "wis",
      "cha"
    ]
  },
  {
    name: "artisan",
    stats: [
      "int",
      "str",
      "dex"
    ]
  },
  {
    name: "charlatan",
    stats: [
      "dex",
      "con",
      "cha"
    ]
  },
  {
    name: "criminal",
    stats: [
      "dex",
      "con",
      "int"
    ]
  },
  {
    name: "entertainer",
    stats: [
      "dex",
      "str",
      "cha"
    ]
  },
  {
    name: "farmer",
    stats: [
      "str",
      "con",
      "wis"
    ]
  },
  {
    name: "guard",
    stats: [
      "str",
      "int",
      "con"
    ]
  },
  {
    name: "guide",
    stats: [
      "dex",
      "con",
      "wis"
    ]
  },
  {
    name: "hermit",
    stats: [
      "wis",
      "con",
      "cha"
    ]
  },
  {
    name: "merchant",
    stats: [
      "int",
      "con",
      "cha"
    ]
  },
  {
    name: "noble",
    stats: [
      "str",
      "int",
      "cha"
    ]
  },
  {
    name: "sage",
    stats: [
      "int",
      "con",
      "wis"
    ]
  },
  {
    name: "sailor",
    stats: [
      "dex",
      "str",
      "wis"
    ]
  },
  {
    name: "scribe",
    stats: [
      "dex",
      "int",
      "wis"
    ]
  },
  {
    name: "soldier",
    stats: [
      "dex",
      "con",
      "str"
    ]
  },
  {
    name: "wayfarer",
    stats: [
      "dex",
      "wis",
      "cha"
    ]
  },
]

backgrounds.each do |bg_data|
  bg = Background.create(name: bg_data[:name], game_system_id: dnd2024.id)
  bg_data[:stats].each do |abbr|
    stat = CharacterStat.find_by(abbreviation: abbr)
    bg.character_stats << stat
  end
end

# Appearances
appearances = [
  "Distinctive jewelry",
  "Flamboyant, outlanding, formal, or ragged clothes",
  "Uses an elegant mobility device (wheelchair, brace, or cane)",
  "Pronounced scar",
  "Unusual eye color (or two different colors)",
  "Tattoos or piercings",
  "Birthmark",
  "Unusual hair color",
  "Bald, or braided beard or hair",
  "Distinctive nose (large, bulbous, angular, small)",
  "Distinctive posture (stooped or rigid)",
  "Exceptionally beautiful or ugly",
]

appearances.each do |a|
  CharacterAppearance.create(appearance: a, game_system_id: dnd2024.id)
end
