class MilitaryUnitFollower < ApplicationRecord
  include Follower
  enum :experience, { green: 0, regular: 1, seasoned: 2, veteran: 3, elite: 4, super_elite: 5 }
  enum :equipment, { light: 0, medium: 1, heavy: 2, super_heavy: 3, unequipped: 4 }
  enum :unit_type, { infantry: 0, cavalry: 1, flying: 2, archers: 3, levies: 4, siege_engine: 5 }

  def display_name(level)
    "#{experience.sub("_", " ").titleize} #{equipment.sub("_", " ").titleize} (size 1d#{unit_sizes[level - 1]}), Unit"
  end

  def unit_sizes
    [4, 6, 8, 10, 12, 20]
  end
end