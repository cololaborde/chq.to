class EphemeralLink < RegularLink
  attribute :used, :boolean
  validates_presence_of :slug, :destination_url
  validates_uniqueness_of :slug
  validates :name, presence: false
end
