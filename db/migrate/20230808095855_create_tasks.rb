class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t| 
      t.string :title
      t.text :description
      t.datetime :duedate
      t.string :priority
      t.string :status
      t.string :category
      t.string :assigned_to
      t.string :completed_at

      t.timestamps
    end
  end
end
