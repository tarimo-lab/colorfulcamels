json.extract! post, :id, :title, :body, :approved, :user_id, :anonymous, :created_at, :updated_at
json.url post_url(post, format: :json)
