json.extract! regular_link, :id, :slug, :name, :destination_url, :user_id, :created_at, :updated_at
json.url regular_link_url(regular_link, format: :json)
