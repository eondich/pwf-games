class CharacterName < ApplicationRecord
  has_and_belongs_to_many source_materials

  enum :name_type, [:given_name, :family_name, :nickname, :clan_name]
  # Assumes ungendered/ambiguous if null
  enum :gender, [:male, :female]
end