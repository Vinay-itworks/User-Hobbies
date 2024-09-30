class User < ApplicationRecord
  has_and_belongs_to_many :hobbies
  validates_presence_of :first_name, :last_name, :birthdate
  validates :first_name, :last_name, length: { in: 3..15 }
  validates :birthdate, comparison: { less_than: 5.year.ago.to_date }
  accepts_nested_attributes_for :hobbies
end
