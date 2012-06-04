require 'sinatra'
require 'haml'
$: << 'lib'
require 'solve/library'
require 'solve/permuter'

LIBRARY = Solve::Library.new


get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  pattern = params['pattern'].gsub(/ /,'_').chars.to_a
  letters = params['letters'].chars.to_a

  permutations = Solve::Permuter.pattern_fill(letters,pattern)

  results = permutations.each.map do |perm|
    perm.downcase if LIBRARY.matches_word?(perm.downcase)
  end.compact

  "".tap do |result|
    result << "Params: #{params.inspect}"
    result << "<hr />"
    result << "You entered #{letters.inspect} for pattern #{pattern.inspect} <br>"
    result << "<hr />"
    result << line("Tested permutations: " + permutations.join(', '))
    result << "<hr />"
    result << line("<h2>Found results:</h2>")
    result << lines(results)
  end
end


def line(str)
  "#{str}<br>"
end

def lines(array)
  array.join("<br>")
end


