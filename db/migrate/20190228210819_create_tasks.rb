class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :details
      t.date :due_date
      t.time :due_time
      t.belongs_to :list, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :board, foreign_key: true

      t.timestamps
    end
  end
end
