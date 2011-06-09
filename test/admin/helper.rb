class Riot::Situation
  # Login Method for Admin App
  # login! :username => 'jim', :password => 'bob'
  #
  def login!(options={})
    options.reverse_merge!(Account.plan)
    Account.make options
    post '/sessions/create', :email => options[:email], :password => options[:password]
  end
end
