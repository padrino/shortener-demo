class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  URL_REGEX    = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix unless defined?(URL_REGEX)
  SLUG_LETTERS = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten unless defined?(SLUG_LETTERS)

  field :url,    :type => String
  field :slug,   :type => String
  field :visits, :type => Integer, :default => 0

  validates_presence_of :url
  validates_format_of   :url, :with => URL_REGEX

  validates_uniqueness_of :slug

  references_many :visitors

  before_create :generate_slug

  def generate_slug
    self.slug = 5.times.map { SLUG_LETTERS.sample }.join
  end

  class << self

    def find_by_slug(slug)
      where(:slug => slug).first
    end

    def find_by_slug!(slug)
      find_by_slug(slug) || raise(Sinatra::NotFound)
    end
  end

end

