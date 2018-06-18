class Animal < ApplicationRecord
  belongs_to :organization

  validates_presence_of :name
end
