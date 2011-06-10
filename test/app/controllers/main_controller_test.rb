require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

context "MainController" do
  set :clean_database, true

  app Shortener

  context "GET :index" do
    setup { get '/' }

    asserts(:body).matches %r{Shortener}
    asserts(:status).equals 200
  end

  context "GET :slug" do
    setup do
      @link = Link.create :url => 'http://www.google.com'
      link = "/#{@link.slug}"
      get link
    end

    asserts(:[],'Location').equals 'http://www.google.com'
    asserts(:status).equals 302
  end
end

