# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Add dnd as a system
dnd = GameSystem.create(name: "dungeons & dragons")

# Ancestries
["human", "halfling", "elf", "tiefling", "half-elf", "dwarf", "gnome", "dragonborn", "hobgoblin", "gnoll", "orc", "lizardfolk"].each do |a|
  ancestry = Ancestry.create(name: a)
  ancestry.game_systems << dnd
end

# Player classes
["barbarian", "bard", "cleric", "druid", "fighter", "monk", "paladin", "ranger", "rogue", "sorcerer", "warlock", "wizard"].each do |class_name|
  pclass = PlayerClass.create(name: class_name)
  pclass.game_systems << dnd
end
