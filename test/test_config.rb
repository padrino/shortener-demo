PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.join(File.dirname(__FILE__),'blueprints')
require 'riot/rr'

Riot.pretty_dots

DatabaseCleaner.strategy = :truncation

# Support Files
Dir.glob(File.expand_path('../support/*.rb',__FILE__)).each { |f| require f }


# Specify your app using the #app helper inside a context.
# Takes either an app class or a block argument.
# app { Padrino.application }
# app { Shortener.tap { |app| } }
class Riot::Situation
  include Rack::Test::Methods
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  # Or just the Application itself like:
  #   Shortener.tap { |app|  }

  def app
    @app || Padrino.application
  end
end

class Riot::Context
  # Set the Rack app which is to be tested.
  #
  #   context "MyApp" do
  #     app { [200, {}, "Hello!"] }
  #     setup { get '/' }
  #     asserts(:status).equals(200)
  #   end
  def app(app=nil, &block)
    setup { @app = (app || block.call) }
  end
end

