class PrivateLink < RegularLink
  attribute :password, :string
  validates_presence_of :password
end
