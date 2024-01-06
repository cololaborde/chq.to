class EphemeralLink < Link
  validates :used, inclusion: { in: [true, false] }
  after_initialize :set_defaults

  def set_defaults
    self.used ||= false
  end
end
