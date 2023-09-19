class PlayerSubclass < ApplicationRecord
  belongs_to :player_class
  has_many :retainer_classes
end