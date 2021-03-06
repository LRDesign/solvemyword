require 'solve/dictionary'

describe Solve::Dictionary do
  let :dictionary do
    Solve::Dictionary.new('dict/american-words.10')
  end
  describe "loading a file" do
    it "should have 35 words" do
      dictionary.words.count.should == 35
    end

    it "should be languange 'american'" do
      dictionary.language.should == 'american'
    end

    it "should be level 10" do
      dictionary.level.should == 10
    end
  end

  describe "include?" do
    it "should not contain 'colour'" do
      dictionary.should_not include('colour')
    end
    it "should contain 'color'" do
      dictionary.should include('color')
    end
  end
end



