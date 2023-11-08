class FollowerRoll < ApplicationRecord
  # Possible followers: Ambassador, artisan, military unit (see military_unit_follower for options),
  # retainer (see retainer_class), special ally
  belongs_to :follower, polymorphic: true
  belongs_to :player_class
  validate :max_roll_greater_than_min_roll

  # Keeping duplicate data for now to simplify having a default table (which will allow
  # easier reuse of styling/table functionality, cleaner templates, etc), but we'll
  # likely want a way to do more complex processing for a column in the long run (so put
  # together the d100 roll on the fly)
  def serialized_for_generator
    {
      id: id.to_s,
      d100: "#{ min_roll.to_i } - #{ max_roll.to_i }",
      min_roll: min_roll.to_i,
      max_roll: max_roll.to_i,
      name: follower.display_name(follower_level || 0),
    }
  end

  def test
    puts "And here"
  end

  private

  def max_roll_greater_than_min_roll
    if max_roll <= min_roll
      errors.add(:max_roll, "must be greater than min_roll")
    end
  end
end