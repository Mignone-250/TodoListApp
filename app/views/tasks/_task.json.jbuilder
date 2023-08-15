json.extract! task, :id, :id, :title, :description, :duedate, :priority, :status, :category, :assigned_to, :created_at, :completed_at, :created_at, :updated_at
json.url task_url(task, format: :json)
