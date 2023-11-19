class PrivateLink < Link
  attribute :password, :string
  validates_presence_of :password
end
