class Link < ApplicationRecord
    belongs_to :user
    validates_presence_of :slug, :destination_url
    validates_uniqueness_of :slug
    validates :name, presence: false
    validates :type, presence: true
  end
  