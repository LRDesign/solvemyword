module Solve
  class ParamsHandler
    def self.handle(params)
      {}.tap do |hash|
        hash[:letters] = params['letters'].chars.to_a.sort
        hash[:pattern] = params['pattern'].gsub(/ /,'_').chars.to_a
      end
    end
  end

  class ParamsException < Exception
  end
end
