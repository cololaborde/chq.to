json.extract! temporal_link, :id, :slug, :name, :destination_url, :user_id, :expiration_date, :created_at, :updated_at
json.url temporal_link_url(temporal_link, format: :json)
