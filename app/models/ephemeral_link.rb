class EphemeralLink < Link
  attribute :used, :boolean, default: false
  validates_presence_of :destination_url
  validates :name, presence: false
end
