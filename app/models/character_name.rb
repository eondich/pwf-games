class CharacterName < ApplicationRecord
  has_and_belongs_to_many :ancestries
  has_and_belongs_to_many :game_systems
  has_and_belongs_to_many :name_styles

  enum :name_type, [:given_name, :family_name, :nickname, :clan_name, :nickname_piece]
  # Assumes ungendered/ambiguous if null
  enum :gender, [:female, :male]
end