class Link < ApplicationRecord
  belongs_to :user
  validates :slug, presence: true, uniqueness: true
  validates :destination_url, presence: true
  validates :type, presence: true
  validates :destination_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  has_many :link_accesses, dependent: :destroy

  before_validation :set_slug, on: :create

  private

  def set_slug
    self.slug = SlugGenerator.generate
  end

end
  