require 'bundler/setup'
Bundler.require(:default)


$: << 'lib'
require 'solve/library'
require 'solve/permuter'
require 'solve/params_handler'


LIBRARY = Solve::Library.new


get '/' do
  haml :index, :format => :html5
end

get '/solve' do
  begin
    inputs = Solve::ParamsHandler.handle(params)
    permutations = Solve::Permuter.pattern_fill(inputs)

    results = permutations.each.map do |perm|
      perm.downcase if LIBRARY.matches_word?(perm.downcase)
    end.compact

    haml :results, :format => :html5, :locals => {
      :results => results,
      :permutations => permutations
    }.merge!(inputs)
  rescue Exception => ex
    haml :error, :format => :html5, :locals => {
      :exception => ex
    }
  end
end

get '/application.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :application
end
