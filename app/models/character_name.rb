class CharacterName < ApplicationRecord
  enum :name_type, [:given_name, :family_name, :nickname, :clan_name]
  # Assumes ungendered/ambiguous if null
  enum :gender, [:male, :female]
end