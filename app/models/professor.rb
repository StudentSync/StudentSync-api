class Professor < ApplicationRecord
  belongs_to :user

  validates :user, uniqueness: true
  validates :name, presence: true
end
