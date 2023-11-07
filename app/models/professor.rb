class Professor < ApplicationRecord
  belongs_to :user

  validates :user, uniqueness: true, presence: true
  validates :name, presence: true
end
