require 'sinatra'
require 'haml'

LIBRARY = {}


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

  wordcount = dictionaries.reduce(0){|sum, d| sum += d.count; sum}
  p "dictionaries count: #{dictionaries.count}"
  #dictionaries.each do |dic|
    #p [dic.count, dic[0]]

  #end

  "".tap do |result|
    result << "Params: #{params.inspect}"
    result << "<hr />"
    result << "You entered #{letters.inspect} for pattern #{pattern.inspect} <br>"
    result << "<hr />"
    result << line("Tested permutations: " + permutations.join(', '))
    result << "<hr />"
    result << "Against #{dictionaries.count} dictionaries with #{wordcount} words"
    result << "<hr />"
    result << "Available dictionaries include #{lines(LIBRARY.keys)}"
  end
end

def dictionaries
  languages = ['english', 'american']
  limit = 70
  [].tap do |dicts|
    languages.each do |lang|
      p lang
      dicts << LIBRARY[lang].keys.map do |level|
        LIBRARY[lang][level] if level <= limit
      end
    end
  end
end

def line(str)
  "#{str}<br>"
end

def lines(array)
  array.join("<br>")
end


dictionaries
