require File.expand_path('../../test_config', __FILE__)

context "Api Controller" do
  set :clean_database, true

  app Api

  context "GET :show" do

    context "with valid link" do
      setup do
        link = Link.create :url => 'http://www.google.com'
        get '/show.json', :slug => link.slug
      end

      asserts(:body).matches %r{google\.com}
      denies(:body).matches %r{error}
      asserts(:status).equals 200
    end

    context "with invalid link" do
      setup { get '/show.json', :slug => 'holy' }

      asserts(:body).equals 'not found'
      asserts(:status).equals 404
    end
  end

  context "POST :create" do

    context "with valid params" do
      setup do
        post '/create.json', :url => 'http://www.google.com'
      end

      asserts(:body).matches %r{google\.com}
      asserts(:status).equals 200
    end

    context "with invalid params" do
      setup do
        post '/create.json', :url => 'http:/1asdfsadf'
      end

      asserts(:body).matches %r{error}
      asserts(:body).matches %r{Url is invalid}
      asserts(:status).equals 200
    end
  end

end
