class Ambassador < ApplicationRecord
  include Follower
  belongs_to :ancestry

  def display_name(level)
    "#{ancestry.name.titleize} Ambassador"
  end
end