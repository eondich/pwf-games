class Ancestry < ApplicationRecord
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :game_systems
  has_many :lineages

  def serialized_for_character_generator
    {
      id: id.to_s, 
      name: name.titleize
    }
  end
end