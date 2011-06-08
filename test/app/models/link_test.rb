require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

context "Link Model" do
  set :clean_database, true

  context "definition" do
    setup { Link }

    denies("URL_REGEX")    { 'http://www.google.com.$' }.matches Link::URL_REGEX
    denies("SLUG LETTERS") { topic::SLUG_LETTERS.join  }.matches %r{[^a-zA-Z0-9]}

    asserts_topic.has_field :url,    :type => String
    asserts_topic.has_field :slug,   :type => String
    asserts_topic.has_field :visits, :type => Integer, :default => 0

    asserts_topic.has_validation :validates_presence_of, :url
    asserts_topic.has_validation :validates_format_of,   :url, :with => Link::URL_REGEX

    asserts_topic.has_validation :validates_uniqueness_of, :slug

    asserts_topic.has_association :references_many, :visitors
  end

  context "#generate_slug" do
    setup do
      Link.create :url => 'http://www.google.com'
    end

    asserts(:slug).exists
    asserts(:slug).size 5
    asserts(:slug).matches %r{[a-zA-Z0-9]}
  end

  context "#find_by_slug" do
    setup do
      Link.create :url => 'http://www.google.com'
    end

    asserts "that it returns the document if it exists" do
      Link.find_by_slug(topic.slug) == topic
    end

    denies "that it returns the document if it exists" do
      Link.find_by_slug('bull')
    end
  end

  context "#find_by_slug!" do
    setup do
      Link.create :url => 'http://www.google.com'
    end

    asserts "that it returns the document if it exists" do
      Link.find_by_slug!(topic.slug) == topic
    end

    asserts "that if the given slug doesn't exist that" do
      Link.find_by_slug!('bull')
    end.raises Sinatra::NotFound
  end
end


