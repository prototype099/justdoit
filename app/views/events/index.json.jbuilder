json.array!(@events) do |event|
  json.extract! event, :id, :owner_id, :title, :description, :place, :start_time, :end_time
  json.url event_url(event, format: :json)
end
