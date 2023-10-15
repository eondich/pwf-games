class CharacterName < ApplicationRecord
  enum :name_type, [:given_name, :family_name, :nickname, :clan_name]
end