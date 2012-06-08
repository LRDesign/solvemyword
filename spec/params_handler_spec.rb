require 'solve/params_handler'

describe Solve::ParamsHandler do
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
  end
end

