class GameSystem < ApplicationRecord
  has_and_belongs_to_many :ancestries
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :player_classes
end