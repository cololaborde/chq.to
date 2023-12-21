class EphemeralLink < Link
  validates :used, inclusion: { in: [true, false] }
end
