class ChangeDueDateDataTypeInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :duedate, :date
  end
end
