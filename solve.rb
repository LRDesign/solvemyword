require 'sinatra'
require 'haml'

dictionary = {}

Dir.glob('dict/*-words.*') do |dict_file|
  lang = dict_file.match(/(\w+)-words/)[1].to_s
  size = dict_file.match(/\.(\d+)/)[1].to_i
  if size < 90
    dictionary[lang] ||= {}
    dictionary[lang][size] = File.readlines(dict_file).map{|word| word.chomp}
    dictionary
  end
end

get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  pattern = params['pattern'].gsub(/ /,'_').chars.to_a
  letters = params['letters'].chars.to_a
  p pattern
  p letters

  permutations = letters.permutation.map do |lets|
    p lets
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


  "".tap do |result|
    result << "Params: #{params.inspect}"
    result << "<hr />"
    result << "You entered #{letters.inspect} for pattern #{pattern.inspect} <br>"
    result << "<hr />"
    result << "Tested permutations: " + lines(permutations)
    result << "<hr />"
    result << "Available dictionaries include #{lines(dictionary.keys)}"
  end
end


def line(str)
  "#{str}<br>"
end

def lines(array)
  array.join("<br>")
end
