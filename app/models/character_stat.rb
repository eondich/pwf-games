class CharacterStat < ApplicationRecord
  has_and_belongs_to_many :backgrounds
  belongs_to :game_system
end