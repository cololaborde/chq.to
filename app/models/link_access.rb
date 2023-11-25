class LinkAccess < ApplicationRecord
  belongs_to :link

  def self.ransackable_attributes(auth_object = nil)
    %w[accessed_at ip_address]
  end

end
