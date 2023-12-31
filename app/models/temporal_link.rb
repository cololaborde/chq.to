class TemporalLink < Link
  validates :expiration_date, presence: true
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date <= DateTime.current
      errors.add(:expiration_date, "La fecha y hora de vencimiento deben ser posteriores a la actual.")
    end
  end
end
