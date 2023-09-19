class PlayerClass < ApplicationRecord
  has_many :player_subclasses
  has_many :follower_rolls

  def serialized_for_follower_generator
    {
      value: id,
      name: name.titleize
    }
  end
end