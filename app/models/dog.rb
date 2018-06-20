class Dog < Animal
  belongs_to :organization

  validates_presence_of :name
end
