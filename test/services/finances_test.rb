require 'test_helper'

describe Finances do
  include TestHelper

  Struct.new("Finance", :id, :name, :tag_amount, :amount_wagered, :amount_to_win, :outcome)
  let(:won_finance){Struct::Finance.new(1, 'homer', 5.0, 15.0, 18.0, 'Won' )}
  let(:lost_finance){Struct::Finance.new(1, 'homer', 5.0, 15.0, 18.0, 'Lost' )}
  let(:bart_won_finance){Struct::Finance.new(1, 'bart', 5.0, 15.0, 18.0, 'Won' )}
  let(:bart_lost_finance){Struct::Finance.new(1, 'bart', 5.0, 15.0, 18.0, 'Lost' )}

  let(:mock_finances){[won_finance, lost_finance]}

  # describe "all" do
  #   before do
  #     Finances.stub(:finances,[won_finance, lost_finance, bart_won_finance, bart_lost_finance])
  #   end

  #   it "should return a hash of 2" do
  #     Finances.all.must_be_instance_of Hash
  #     Finances.all.length.must_equal 2
  #   end

  #   it "should return a struct" do
  #     Finances.all.length.must_equal 2
  #   end
  # end


  describe "Calculated Amount" do

    it "should return an amount for a won wager" do
      Finances.amount_won(mock_finances).must_equal 11.0
    end

    it "should return zero for a lost wager" do
      Finances.amount_won(mock_finances).must_equal 0.0
    end
  end
end