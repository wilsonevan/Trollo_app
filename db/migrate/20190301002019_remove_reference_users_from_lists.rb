class RemoveReferenceUsersFromLists < ActiveRecord::Migration[5.2]
  def change
    remove_reference :lists, :users, foreign_key: true
  end
end
