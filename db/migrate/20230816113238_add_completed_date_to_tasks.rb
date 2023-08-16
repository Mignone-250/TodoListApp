class AddCompletedDateToTasks < ActiveRecord::Migration[7.0]
  def up
    add_column :tasks, :completed_date, :date

    # Update the new column with data from the old column
    Task.all.each do |task|
      task.update(completed_date: task.completed_at.to_date) if task.completed_at
    end
  end

  def down
    # Copy data back from completed_date to completed_at if needed

    remove_column :tasks, :completed_date
  end
end
