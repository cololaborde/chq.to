class TemporalLink < RegularLink
  attribute :expiration_date, :datetime
  validates_presence_of :expiration_date
  validate :expiration_date_cannot_be_in_the_past
end
