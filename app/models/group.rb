class Group < ApplicationRecord
  belongs_to :user

  has_many :group_users
  accepts_nested_attributes_for :group_users
end
