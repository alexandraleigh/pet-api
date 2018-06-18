class Organization < ApplicationRecord
  has_many :animals, dependent: :destroy

  validates_presence_of :name, :line1, :line2, :city, :state, :zipcode, :phone
end
