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
  pattern = params['pattern'].gsub(/_/,' ').chars
  letters = params['letters'].chars
  p pattern
  p letters

  #possibilities = [].tap do |arr|
    #letters.permutations.each do |lets|

    #end
  #end

  "".tap do |result|
    result << "Params: #{params.inspect}"
    result << "<hr />"
    result << "You entered #{letters.inspect} for pattern #{pattern.inspect} <br>"
    result << "Available dictionaries include #{dictionary.keys}"
  end
end
