class Ancestry < ApplicationRecord
  has_and_belongs_to_many :given_names
  has_and_belongs_to_many :surnames
  has_one :ambassador
end