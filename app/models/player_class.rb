class PlayerClass < ApplicationRecord
  has_many :follower_rolls
  has_many :player_subclasses
  has_and_belongs_to_many :source_materials

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