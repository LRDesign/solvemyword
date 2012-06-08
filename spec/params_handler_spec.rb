require 'solve/params_handler'

describe Solve::ParamsHandler do

  describe "letters_only?" do
    it "should be true for letters" do
      Solve::ParamsHandler.letters_only?('abcdefghABCDEFGH').should be_true
    end
    it "should be false if it contains punctuation" do
      Solve::ParamsHandler.letters_only?('abcdefg&&CDEFGH').should be_false
    end
    it "should be false if it contains numbers" do
      Solve::ParamsHandler.letters_only?('abcdefg12CDEFGH').should be_false
    end
    it "should be false for letters and spaces" do
      Solve::ParamsHandler.letters_only?('abcde   ABCDEFGH').should be_false
    end
    it "should be false for underscores and hyphens" do
      Solve::ParamsHandler.letters_only?('abcde__--ABCDEFGH').should be_false
    end
  end
  describe "bad_chars?" do
    it "should be false for letters" do
      Solve::ParamsHandler.bad_chars?('abcdefghABCDEFGH').should be_false
    end
    it "should be true if it contains punctuation" do
      Solve::ParamsHandler.bad_chars?('abcdefg&&CDEFGH').should be_true
    end
    it "should be true if it contains numbers" do
      Solve::ParamsHandler.bad_chars?('abcdefg12CDEFGH').should be_true
    end
    it "should be false for letters and spaces" do
      Solve::ParamsHandler.bad_chars?('abcde   ABCDEFGH').should be_false
    end
    it "should be false for underscores and hyphens" do
      Solve::ParamsHandler.bad_chars?('abcde__--ABCDEFGH').should be_false
    end
  end

  describe 'handle' do
    let :valid_params do
      { 'letters' => 'abcdef', 'pattern' => '  o   ' }
    end
    describe "on valid params" do

      it "should generate the right array of letters" do
        Solve::ParamsHandler.handle(valid_params)[:letters].should == ['a', 'b', 'c', 'd', 'e', 'f']
      end
      it "should generate the right pattern array" do
        Solve::ParamsHandler.handle(valid_params)[:pattern].should == ['_', '_', 'o', '_', '_', '_']
      end
    end

    describe "with a too-long array of letters" do
      it "should raise a ParamsException" do
        lambda do
          Solve::ParamsHandler.handle(valid_params.merge!({'letters' => 'abcdefghijklmnopqrstuvwxyz'}))
        end.should raise_exception(Solve::ParamsException)
      end
    end

    describe "with special characters" do
      it "should raise a ParamsException" do
        lambda do
          Solve::ParamsHandler.handle(valid_params.merge!({'letters' => 'abc13$qg;'}))
        end.should raise_exception(Solve::ParamsException)
      end
    end

    describe "with pattern missing" do
      it "should raise a ParamsException" do
        lambda do
          Solve::ParamsHandler.handle(valid_params.merge!({'pattern' => ''}))
        end.should raise_exception(Solve::ParamsException)
      end

    end
    describe "with letters missing" do
      it "should raise a ParamsException" do
        lambda do
          Solve::ParamsHandler.handle(valid_params.merge!({'letters' => ''}))
        end.should raise_exception(Solve::ParamsException)
      end

    end

  end
end

