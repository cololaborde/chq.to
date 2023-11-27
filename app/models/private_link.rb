class PrivateLink < Link
  attribute :password, :string
  validates :password, presence: true
end
