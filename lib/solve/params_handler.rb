module Solve
  class ParamsHandler
    LETTERS_LIMIT = 8

    def self.handle(params)
      params['letters'].gsub!(/\s/,'')
      check_for_valid_params(params)
      {}.tap do |hash|


        hash[:letters] = params['letters'].chars.to_a.sort
        hash[:pattern] = params['pattern'].gsub(/[ -]/,'_').chars.to_a
      end
    end

    def self.check_for_valid_params(params)
      if params['letters'].nil? or params['letters'] == '' or params['pattern'].nil? or params['pattern'] == ''
        raise ParamsException.new("Please provide both a pattern and a group of letters.")
      end

      raise ParamsException.new("Too many letters.   Sorry, 8 is the limit for now.") unless params['letters'].length <= LETTERS_LIMIT

      if !letters_only?(params['letters']) or bad_chars?(params['pattern'])
        raise ParamsException.new("Invalid characters - letters only please!")
      end
    end

    def self.bad_chars?(value)
      value =~ /[^a-zA-Z _-]/
    end

    def self.letters_only?(value)
      value =~ /^[a-zA-Z]*$/
    end


  end

  class ParamsException < Exception
  end
end
