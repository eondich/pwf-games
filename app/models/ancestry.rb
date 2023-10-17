class Ancestry < ApplicationRecord
  has_one :ambassador
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :source_materials
end