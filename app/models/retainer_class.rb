class RetainerClass < ApplicationRecord
  include Follower
  belongs_to :player_subclass

  def display_name(level)
    "#{name.titleize} (#{level.to_i.ordinalize} Level), Retainer"
  end
end