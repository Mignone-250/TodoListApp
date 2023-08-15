class Task < ApplicationRecord
	belongs_to :user
	def self.statuses
    {
      'completed' => 'Completed',
      'ongoing' => 'Ongoing',
      'pending' => 'Pending'
    }
  end
  validates :title, presence: true, on: :update
  validates :description, presence: true, on: :update
  validates :assigned_to, presence: true, on: :update
   validates :title, uniqueness: { message: " :The task with the same title already exists." }

  validates :title, :description, :duedate, :priority, :status, :category, :assigned_to, presence: true
  validate :assigned_to_must_not_contain_numbers
  validates :title, presence: true, length: { minimum: 5 } # Adjust the minimum length as needed
  validates :description, presence: true, length: { minimum: 10 }

  def assigned_to_must_not_contain_numbers
    if assigned_to.match?(/\d/)
      errors.add(:assignee, "cannot contain numbers")
    end
  end
  validate :completed_date_in_past, if: :completed_task?

  private

  def completed_task?
    status == "completed"
  end

  def completed_date_in_past
    if completed_at.present? && completed_task? && completed_at > Date.today
      errors.add(:completed_at, " : Completion date cannot be in the future if task is completed")
    end
  end
end
