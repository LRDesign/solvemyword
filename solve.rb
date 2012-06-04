require 'sinatra'
require 'haml'

get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  "You entered #{params.inspect}"
end
