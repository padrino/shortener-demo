require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

context "Visitor Model" do
  set :clean_database, true

  context "definition" do
    setup { Visitor }

    asserts_topic.has_field :ip,       :type => String
    asserts_topic.has_field :referrer, :type => String

    asserts_topic.has_association :referenced_in, :link
  end
end
