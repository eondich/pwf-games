class GameSystem < ApplicationRecord
  has_and_belongs_to_many :ancestries
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :player_classes
  has_and_belongs_to_many :name_styles
  has_many :character_stats
  has_many :backgrounds
  has_many :character_appearances

  def serialized_for_character_generator
    {
      id: id,
      name: name,
      key: key
    }
  end
end