class TemporalLink < Link
  attribute :expiration_date, :datetime
  validates_presence_of :expiration_date
end