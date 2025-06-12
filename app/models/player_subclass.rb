class PlayerSubclass < ApplicationRecord
  belongs_to :player_class
  has_and_belongs_to_many :game_systems

  def serialized_for_character_generator
    {
      id: id.to_s,
      name: full_title
    }
  end

  private

  def full_title
    subclass_title = name
    if player_class.name_modifier
      if player_class.name_modifier_is_prefix
        subclass_title = "#{player_class.name_modifier} #{subclass_title}"
      else
        subclass_title = "#{subclass_title} #{player_class.name_modifier}"
      end
    end

    subclass_title.titleize
  end
end