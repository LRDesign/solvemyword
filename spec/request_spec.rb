
require 'solve'  # <-- your sinatra app
require 'test/spec'
require 'rack/test'

set :environment, :test

describe 'The solver' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    last_response.should.be.ok
  end
end
