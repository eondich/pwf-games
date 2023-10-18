class Ancestry < ApplicationRecord
  has_one :ambassador
  has_and_belongs_to_many :character_names
  has_and_belongs_to_many :source_materials

  def serialized_for_character_generator
    {
      id: id, 
      name: name.titleize
    }
  end
end