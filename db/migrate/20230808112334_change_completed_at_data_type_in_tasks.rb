class ChangeCompletedAtDataTypeInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :completed_at, :date
  end
end
