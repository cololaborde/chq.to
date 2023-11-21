class TemporalLink < Link
  attribute :expiration_date, :datetime
  validates_presence_of :expiration_date
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < DateTime.now
      errors.add("La fecha de vencimiento debe ser posterior a la actual.")
    end
  end
end