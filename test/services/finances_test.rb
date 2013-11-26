require 'test_helper'

describe Finances do
  include TestHelper

  Finance = Struct.new("Finance", :id, :name, :tag_amount, :amount_wagered, :amount_to_win, :outcome)
  let(:won_finance){Finance.new(1, 'homer', 5.0, 15.0, 18.0, 'Won' )}
  let(:lost_finance){Finance.new(1, 'homer', 5.0, 15.0, 18.0, 'Lost' )}
  let(:bart_won_finance){Finance.new(1, 'bart', 5.0, 15.0, 18.0, 'Won' )}
  let(:bart_lost_finance){Finance.new(1, 'bart', 5.0, 15.0, 18.0, 'Lost' )}

  let(:mock_finances){[won_finance, lost_finance]}

  describe "Calculated Amount" do

    it "should return the correct won amount" do
      Finances.amount_won(mock_finances).must_equal 11.0
    end

    it "should return the correct wagered amount" do
      Finances.amount_wagered(mock_finances).must_equal 10.0
    end

    it "should return the correct wagered amount" do
      Finances.amount_pending(mock_finances).must_equal 0.0
    end
  end
end