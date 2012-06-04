require 'sinatra'
require 'haml'
$: << 'lib'
require 'solve/library'

LIBRARY = Solve::Library.new


get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  pattern = params['pattern'].gsub(/ /,'_').chars.to_a
  letters = params['letters'].chars.to_a
  p pattern
  p letters

  permutations = letters.permutation.map do |lets|
    n = 0
    pattern.map do |ch|
      if ch == "_"
        n += 1
        lets[n].to_s
      else
        ch.to_s
      end
    end.join
  end.uniq

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


