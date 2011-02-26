require File.dirname(__FILE__) + '/spec_helper'

describe Bierdopje::Episode do
  describe "#find" do
    it "should find the correct episode based on the id" do
      episode = Bierdopje::Episode.find 163480
      episode.id.should == '163480'
      episode.season.should == '1'
      episode.code.should == 'S01E01'
      episode.show_name.should == 'lost'
      episode.show.name.should == 'Lost'
      episode.show.id.should == '5517'
    end
  end
end
