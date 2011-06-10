require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')
require File.expand_path(File.dirname(__FILE__) + '/../helper.rb')

context "Admin::Links Controller" do
  set :clean_database, true
  set :stub_bcrypt, true

  app Admin

  context "get index" do
    setup do
      login!
      Link.create :url => 'http://www.google.com'
      get '/links'
    end
    asserts(:body).matches %r{google\.com}
    asserts(:status).equals 200
  end

  context "get edit" do
    setup do
      login!
      link = Link.create :url => 'http://www.google.com'
      get "/links/edit/#{link.id}"
    end
    asserts(:body).matches %r{google\.com}
    asserts(:body).matches %r{url}
    asserts(:status).equals 200
  end

  context "get new" do
    setup do
      login!
      get '/links/new'
    end
    asserts(:body).matches %r{url}
    asserts(:status).equals 200
  end

  context "post create" do

    context "with valid link" do
      setup do
        login!
        post '/links/create', :link => { :url => 'http://www.google.com' }
        follow_redirect!
      end
      asserts(:body).matches %r{successful}
      asserts(:status).equals 200
    end

    context "with invalid link" do
      setup do
        login!
        post '/links/create', :link => { :url => 'h/wasdf1z' }
      end
      asserts(:body).matches %r{invalid}
      asserts(:status).equals 200
    end

  end

  context "put update" do

    context "with valid data" do
      setup do
        link = Link.create :url => 'http://www.google.com'
        login!
        put "/links/update/#{link.id}", :link => { :url => 'http://www.padrinorb.com' }
        follow_redirect!
      end
      asserts(:body).matches %r{successful}
      asserts(:status).equals 200
    end


    context "with invalid data" do
      setup do
        link = Link.create :url => 'http://www.google.com'
        login!
        put "/links/update/#{link.id}", :link => { :url => 'asdf11' }
      end
      asserts(:body).matches %r{invalid}
      asserts(:status).equals 200
    end
  end

  context "delete destroy" do

    context "with valid link" do
      setup do
        link = Link.create :url => 'http://www.google.com'
        login!
        delete "/links/destroy/#{link.id}"
        follow_redirect!
      end
      asserts(:body).matches %r{successful}
      asserts(:status).equals 200
    end

    context "with invalid link" do
      setup do
        link = Link.new
        login!
        delete "/links/destroy/#{link.id}"
        follow_redirect!
      end
      asserts(:body).matches %r{Cannot destroy link!}
      asserts(:status).equals 200
    end

  end

end
