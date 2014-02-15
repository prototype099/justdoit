json.array!(@tasks) do |task|
  json.extract! task, :id, :event_id, :user_id, :content, :state
  json.url task_url(task, format: :json)
end
