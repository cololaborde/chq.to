json.extract! private_link, :id, :slug, :name, :destination_url, :user_id, :password, :created_at, :updated_at
json.url private_link_url(private_link, format: :json)
