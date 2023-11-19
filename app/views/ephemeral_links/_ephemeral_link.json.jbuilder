json.extract! ephemeral_link, :id, :slug, :name, :destination_url, :user_id, :used, :created_at, :updated_at
json.url ephemeral_link_url(ephemeral_link, format: :json)
