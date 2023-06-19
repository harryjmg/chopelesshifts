json.extract! reservation, :id, :user_id, :shift_id, :speed_in_ms, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
