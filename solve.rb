require 'sinatra'
require 'haml'
require 'sass'
$: << 'lib'
require 'solve/library'
require 'solve/permuter'

LIBRARY = Solve::Library.new


get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  pattern = params['pattern'].gsub(/ /,'_').chars.to_a
  letters = params['letters'].chars.to_a.sort

  permutations = Solve::Permuter.pattern_fill(letters,pattern)

  results = permutations.each.map do |perm|
    perm.downcase if LIBRARY.matches_word?(perm.downcase)
  end.compact

  haml :results, :format => :html5, :locals => {
    :results => results,
    :permutations => permutations,
    :pattern => pattern,
    :letters => letters
  }
end

get '/application.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :application
end
