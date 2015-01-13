json.array!(@events) do |event|
  json.extract! event, :id, :name, :runt_time, :description, :venue_id, :style, :price, :box_office_num, :tickets_url
  json.url event_url(event, format: :json)
end
