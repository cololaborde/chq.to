class EphemeralLink < Link
  attribute :used, :boolean, default: false
  validates :used, inclusion: { in: [true, false] }
end
