require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')
require File.expand_path(File.dirname(__FILE__) + '/../helper.rb')

context "Admin::Accounts Controller" do
  set :clean_database, true
  set :stub_bcrypt, true

  app Admin

  context "get index" do
    setup do
      login!
      Account.make :email => 'bob@test.com'
      get '/accounts'
    end
    asserts(:body).matches %r{bob@test.com}
    asserts(:status).equals 200
  end

  context "get edit" do
    setup do
      login!
      account = Account.make :email => 'jim@test.com'
      get "/accounts/edit/#{account.id}"
    end
    asserts(:body).matches %r{jim@test.com}
    asserts(:body).matches %r{email}
    asserts(:status).equals 200
  end

  context "get new" do
    setup do
      login!
      get '/accounts/new'
    end
    asserts(:body).matches %r{email}
    asserts(:status).equals 200
  end

  context "post create" do

    context "with valid account" do
      setup do
        login!
        post '/accounts/create', :account => Account.plan
        follow_redirect!
      end
      asserts(:body).matches %r{successful}
      asserts(:status).equals 200
    end

    context "with invalid account" do
      setup do
        login!
        post '/accounts/create', :account => Account.plan(:email => 'a')
      end
      asserts(:body).matches %r{short}
      asserts(:status).equals 200
    end

  end

  context "put update" do

    context "with valid data" do
      setup do
        account = Account.make :email => 'janedoe@test.com'
        login!
        put "/accounts/update/#{account.id}", :account => { :email => 'sexydoe@test.com' }
        follow_redirect!
      end
      asserts(:body).matches %r{successful}
      asserts(:status).equals 200
    end


    context "with invalid data" do
      setup do
        account = Account.make
        login!
        put "/accounts/update/#{account.id}", :account => { :email => 'a' }
      end
      asserts(:body).matches %r{short}
      asserts(:status).equals 200
    end
  end

  context "delete destroy" do

    context "with valid account" do
      setup do
        account = Account.make
        login!
        delete "/accounts/destroy/#{account.id}"
        follow_redirect!
      end
      asserts(:body).matches %r{successful}
      asserts(:status).equals 200
    end

    context "with invalid account" do
      setup do
        account = Account.new
        login!
        delete "/accounts/destroy/#{account.id}"
        follow_redirect!
      end
      asserts(:body).matches %r{Cannot destroy account!}
      asserts(:status).equals 200
    end

  end

end
