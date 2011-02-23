require File.dirname(__FILE__) + '/spec_helper'

describe Bierdopje::Show do
  describe "#find" do
    it "should find the correct show based on the id" do
      show = Bierdopje::Show.find 5517
      show.id.should == '5517'
      show.tvdb_id.should == '73739'
      show.name.should == 'Lost'
    end
  end

  describe "find_by_name" do
    it "should find the correct show based on it's exact name" do
      show = Bierdopje::Show.find_by_name 'Lost'
      show.id.should == '5517'
      show.tvdb_id.should == '73739'
      show.name.should == 'Lost'
    end
  end
end
