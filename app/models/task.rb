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
  
end
