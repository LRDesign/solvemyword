require 'solve/dictionary'
module Solve
  class Library
    LIMIT = 80
    DEFAULT_LEVEL = 80
    DEFAULT_OPTS = {
      :language => 'american',
      :level => DEFAULT_LEVEL
    }

    attr_accessor :dictionaries

    def initialize
      Dir.glob('dict/*-words.*') do |dict_file|
        level = dict_file.match(/\.(\d+)/)[1].to_i
        if level <= LIMIT
          @dictionaries ||= []
          @dictionaries << Dictionary.new(dict_file)
        end
      end
    end

    def matches_word?(word, opts = DEFAULT_OPTS)

    end

    def selected_dictionaries(opts = DEFAULT_OPTS)
      languages = ['english'] + [*opts[:language]]
      level = opts[:level] || DEFAULT_LEVEL

      @dictionaries.select do |d|
        languages.include?(d.language) && (d.level <= level)
      end
    end

  end
end

