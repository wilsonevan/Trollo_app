class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user
  belongs_to :board
end
