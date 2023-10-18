class SourceMaterial < ApplicationRecord
  has_and_belongs_to_many :ancestries
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :player_classes
  has_and_belongs_to_many :player_subclasses

  def serialized_for_character_generator
    {
      id: id,
      name: name.titleize
    }
  end
end
