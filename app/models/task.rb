
class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user
  belongs_to :board
  
  def self.order_by_due_date
    order(:due_time)  
    order(:due_date)
  end

  def self.order_by_date_created
    order(:date_created)
  end
end