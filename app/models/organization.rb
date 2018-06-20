class Organization < ApplicationRecord
  has_many :dogs, dependent: :destroy

  validates_presence_of :name, :line1, :city, :state, :zipcode, :phone
end
