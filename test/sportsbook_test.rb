require 'test_helper'

describe "Sportsbook" do
  let(:sportsbook){SportsbookApi.sportsbook}

  it "should instantiate" do
    sportsbook.wont_be_nil
  end

  it "should login" do
    sportsbook.login.wont_be_nil
  end

  it "should retrieve data - 2 steps" do
    sportsbook.login
    sportsbook.get_wager_data("LAST_WEEK").wont_be_nil
  end

  it "should retrieve data" do
    sportsbook.get_sb_data("LAST_WEEK").wont_be_nil
  end

end

