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

  describe "selected_dictionaries" do

    it "should return an array of Dictionaries" do
      library.selected_dictionaries.should be_a(Array)
      library.selected_dictionaries.each do |item|
        item.should be_a(Solve::Dictionary)
      end
    end

    describe "level selection" do
      let :dictionaries do
        library.selected_dictionaries(:level => 50)
      end
      it "should not include any dictionaries above that level" do
        dictionaries.map{|d| d.level}.each do |level|
          (level > 50).should_not be_true
        end
      end

    end

    describe "language selction" do
      describe "with one language selected" do
        let :american_dictionaries do
          library.selected_dictionaries(:language => 'american')
        end

        it "should include english dictionaries" do
          american_dictionaries.map{|d| d.language}.should include('english')
        end
        it "should include american dictionaries" do
          american_dictionaries.map{|d| d.language}.should include('american')
        end
        it "should not include british or canadian dictionaries" do
          american_dictionaries.map{|d| d.language}.should_not include('british', 'canadian')
        end
      end
      describe "with two language selected" do
        let :dictionaries do
          library.selected_dictionaries(:language => ['american', 'canadian'])
        end

        it "should include english dictionaries" do
          dictionaries.map{|d| d.language}.should include('english')
        end
        it "should include american and canadian dictionaries" do
          dictionaries.map{|d| d.language}.should include('american', 'canadian')
        end
        it "should not include british dictionaries" do
          dictionaries.map{|d| d.language}.should_not include('british')
        end
      end
    end

  end


end




