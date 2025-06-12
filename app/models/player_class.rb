class PlayerClass < ApplicationRecord
  has_and_belongs_to_many :game_systems
  has_many :player_subclasses

  def serialized_for_follower_generator
    {
      id: id.to_s,
      name: name.titleize
    }
  end

  def serialized_for_character_generator
    {
      id: id.to_s,
      name: name.titleize
    }
  end
end