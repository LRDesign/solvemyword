module Solve
  class Permuter
    def self.pattern_fill(inputs)
      inputs[:letters].permutation.map do |lets|
        n = 0
        inputs[:pattern].map do |ch|
          if ch == "_"
            n += 1
            lets[n-1].to_s
          else
            ch.to_s
          end
        end.join
      end.uniq
    end
  end
end
