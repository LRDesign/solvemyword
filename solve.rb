require 'sinatra'

get '/' do
  'Hello world!  Please <a href="link">click the link!</a>'
end

get '/link' do
  'You clicked the link!'
end
