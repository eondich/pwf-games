class PlayerSubclass < ApplicationRecord
  belongs_to :player_class
  has_many :retainer_classes
  has_and_belongs_to_many :source_materials
end