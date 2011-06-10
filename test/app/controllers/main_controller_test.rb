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
      get link, {}, {'HTTP_REFERER' => 'http://www.padrinorb.com' }
    end

    asserts(:[],'Location').equals 'http://www.google.com'
    asserts(:status).equals 302

    asserts('that it has ip')       { @link.visitors.first.ip       }.equals '127.0.0.1'
    asserts('that it has referrer') { @link.visitors.first.referrer }.equals 'http://www.padrinorb.com'
  end
end

