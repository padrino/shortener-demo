require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

context "LinksController" do
  set :clean_database, true

  app Shortener

  context "GET :show" do
    setup do
      link = Link.create :url => 'http://www.google.com'
      get "/links/show/#{link.slug}"
    end

    asserts(:body).matches %r{google\.com}
    asserts(:status).equals 200
  end

  context "GET :new" do
    setup { get '/links/new' }

    asserts(:body).matches %r{url}
    asserts(:status).equals 200
  end

  context "POST :create" do

    context "with valid params" do
      setup do
        post '/links/create', :link => { :url => 'http://www.google.com' }
      end

      asserts(:status).equals 302
    end

    context "with invalid params" do
      setup do
        post '/links/create', :link => { :url => 'http:/www.google.c$' }
      end

      asserts(:body).matches %r{invalid}
      asserts(:status).equals 200
    end

  end

end

