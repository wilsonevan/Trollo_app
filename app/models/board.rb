class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy
  has_many :tasks, through: :lists
end
