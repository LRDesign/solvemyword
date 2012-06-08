module Solve
  class ParamsHandler
    LETTERS_LIMIT = 8

    def self.handle(params)
      check_for_valid_params(params)
      {}.tap do |hash|


        hash[:letters] = params['letters'].chars.to_a.sort
        hash[:pattern] = params['pattern'].gsub(/ /,'_').chars.to_a
      end
    end

    def self.check_for_valid_params(params)
      raise ParamsException.new("Too many letters.   Sorry, 8 is the limit for now.") unless params['letters'].length <= LETTERS_LIMIT
    end


  end

  class ParamsException < Exception
  end
end
