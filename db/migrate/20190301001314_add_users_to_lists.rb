class AddUsersToLists < ActiveRecord::Migration[5.2]
  def change
    add_reference :lists, :users, foreign_key: true
  end
end
