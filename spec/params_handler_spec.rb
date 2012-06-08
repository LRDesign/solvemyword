require 'solve/params_handler'

describe Solve::ParamsHandler do
  describe 'handle' do
    describe "on valid params" do
      let :valid_params do
        { 'letters' => 'abcdef', 'pattern' => '  o   ' }
      end

      it "should generate the right array of letters" do
        Solve::ParamsHandler.handle(valid_params)[:letters].should == ['a', 'b', 'c', 'd', 'e', 'f']
      end
      it "should generate the right pattern array" do
        Solve::ParamsHandler.handle(valid_params)[:pattern].should == ['_', '_', 'o', '_', '_', '_']
      end
    end
  end
end

