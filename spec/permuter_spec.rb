require 'solve/permuter'

describe Solve::Permuter do

  describe "pattern_fill" do
    let :pattern do ['_','_','_'] end
    let! :pattern_fill do
      Solve::Permuter.pattern_fill(['a','b','c'], pattern)
    end
    it "should return an array of strings" do
      pattern_fill.should be_a(Array)
      pattern_fill.each do |fill|
        fill.should be_a(String)
      end
    end

    it "should have the right number of permutations" do
      pattern_fill.length.should == 6
    end
    it "should have the right size of putput strings" do
      pattern_fill.each do |fill|
        fill.length.should == pattern.length
      end
    end

  end

end
