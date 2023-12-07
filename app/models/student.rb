class Student < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user, uniqueness: true
  validates :name, presence: true
  validates :semester, presence: true
end
