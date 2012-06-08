require 'sinatra'
require 'haml'
require 'sass'
$: << 'lib'
require 'solve/library'
require 'solve/permuter'
require 'solve/params_handler'

LIBRARY = Solve::Library.new


get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  inputs = Solve::ParamsHandler.handle(params)
  permutations = Solve::Permuter.pattern_fill(inputs)

  results = permutations.each.map do |perm|
    perm.downcase if LIBRARY.matches_word?(perm.downcase)
  end.compact

  haml :results, :format => :html5, :locals => {
    :results => results,
    :permutations => permutations
  }.merge!(inputs)
end

get '/application.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :application
end
