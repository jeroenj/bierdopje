require File.dirname(__FILE__) + '/spec_helper'

describe Bierdopje::Episode do
  describe "instance" do
    describe "subtitles" do
      it "should find all subtitles for a given episode" do
        episode = Bierdopje::Episode.find 163480
        subtitles = episode.subtitles
        subtitles.count.should >= 2
        subtitles.collect(&:file_name).should include('Lost.S01E01.DVDRip.XviD.AC3-UnSeeN.srt')
        subtitles.collect(&:file_name).should include('lost.s01e01.dvdrip.xvid-wat.nl.srt')
      end
    end
  end

  describe "#find" do
    it "should find the correct episode based on the id" do
      episode = Bierdopje::Episode.find 163480
      episode.id.should == '163480'
      episode.season.should == '1'
      episode.episode.should == '1'
      episode.code.should == 'S01E01'
      episode.title.should == 'Pilot (1)'
      episode.summary.should include('Stripped of everything, the 48 survivors scavenge what they can from the plane for their survival.')
      episode.air_date.should == '22-09-2004'
      episode.show_name.should == 'lost'
      episode.show.name.should == 'Lost'
      episode.show.id.should == '5517'
    end
  end
end
