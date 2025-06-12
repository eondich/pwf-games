class NameStyle < ApplicationRecord
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :game_systems

  def serialized_for_character_generator
    {
      id: id,
      name: style.titleize
    }
  end
end