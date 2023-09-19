module Follower
  extend ActiveSupport::Concern

  included do
    has_many :follower_rolls, as: :follower
    
    def display_name(level)
      name.titleize
    end
  end
end