require File.dirname(__FILE__) + '/spec_helper'

describe Bierdopje::Episode do
  describe "#find" do
    it "should find the correct subtitles based on the show_id, season_number and episode_number" do
      subtitles = Bierdopje::Subtitle.find 5517, 1, 1
      subtitles.count.should >= 2
      subtitles.collect(&:file_name).should include('Lost.S01E01.DVDRip.XviD.AC3-UnSeeN.srt')
      subtitles.collect(&:file_name).should include('lost.s01e01.dvdrip.xvid-wat.nl.srt')
    end
  end
end
