class CharacterAppearance < ApplicationRecord
  belongs_to :game_system

  def serialized_for_character_generator
    {
      id: id.to_s, 
      name: appearance.upcase_first
    }
  end
end