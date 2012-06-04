require 'solve/dictionary'
module Solve
  class Library
    attr_accessor :dictionaries

    def initialize
      Dir.glob('dict/*-words.*') do |dict_file|
        lang = dict_file.match(/(\w+)-words/)[1].to_s
        size = dict_file.match(/\.(\d+)/)[1].to_i
        if size < 90
          @dictionaries ||= []
          @dictionaries << Dictionary.new(dict_file)
        end
      end
    end
  end
end

