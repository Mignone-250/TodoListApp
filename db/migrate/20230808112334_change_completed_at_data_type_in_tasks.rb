class ChangeCompletedAtDataTypeInTasks < ActiveRecord::Migration[7.0]
  def up
    change_column :tasks, :completed_at, :date, using: 'completed_at::date'
  end

  def down
    change_column :tasks, :completed_at, :datetime
  end
end
