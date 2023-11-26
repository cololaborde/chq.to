class Link < ApplicationRecord
  belongs_to :user
  validates_presence_of :slug, :destination_url
  validates_uniqueness_of :slug
  validates :name, presence: false
  validates :type, presence: true
  validates :destination_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  has_many :link_accesses, dependent: :destroy
  end
  