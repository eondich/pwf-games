class Background < ApplicationRecord
  has_and_belongs_to_many :character_stats
  belongs_to :game_system

  def serialized_for_character_generator
    {
      id: id.to_s, 
      name: name.titleize
    }
  end
end