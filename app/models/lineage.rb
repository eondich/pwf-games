class Lineage < ApplicationRecord
  belongs_to :ancestry
  belongs_to :game_system

  def serialized_for_character_generator
    {
      id: id.to_s, 
      name: name.titleize
    }
  end
end