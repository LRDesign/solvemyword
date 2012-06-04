module Solve
  class Dictionary
    LEVEL_LIMIT = 90
    attr_accessor :language, :level, :words

    def initialize(file_name)
      @language = file_name.match(/(\w+)-words/)[1].to_s
      @level = file_name.match(/\.(\d+)/)[1].to_i
      if @level < 90
        @words = File.readlines(file_name).map{|word| word.chomp}
      end
    end

    def include?(word)
      @words.include?(word)
    end
  end
end

