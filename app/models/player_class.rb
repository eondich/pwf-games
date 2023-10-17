class PlayerClass < ApplicationRecord
  has_many :follower_rolls
  has_many :player_subclasses
  has_and_belongs_to_many :source_materials
end