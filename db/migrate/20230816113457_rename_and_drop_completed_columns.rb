class RenameAndDropCompletedColumns < ActiveRecord::Migration[7.0]
  def up
    rename_column :tasks, :completed_at, :completed_at_old
    rename_column :tasks, :completed_date, :completed_at
  end

  def down
    rename_column :tasks, :completed_at, :completed_date
    rename_column :tasks, :completed_at_old, :completed_at
  end
end
