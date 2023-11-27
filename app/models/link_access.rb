class LinkAccess < ApplicationRecord
  belongs_to :link
  validates :accessed_at, presence: true
  validates :ip_address, presence: true

  # Setea los atributos para permitir la busqueda con ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[accessed_at ip_address]
  end

end
