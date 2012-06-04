require 'solve/library'

describe Solve::Library do
  let :library do
    Solve::Library.new
  end
  describe "instantiation" do
    it "should load a bunch of dictionaries" do
      (library.dictionaries.count > 1).should be_true
      library.dictionaries.each do |dict|
        dict.should be_a(Solve::Dictionary)
      end
    end
  end

end




