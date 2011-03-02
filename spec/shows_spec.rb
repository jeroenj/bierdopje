require File.dirname(__FILE__) + '/spec_helper'

describe Bierdopje::Show do
  describe "instance" do
    describe "#episodes" do
      it "should find all episodes for a given show" do
        show = Bierdopje::Show.find 5517
        episodes = show.episodes
        episodes.collect(&:code).should include('S01E01')
        episodes.collect(&:code).should include('S06E18')
      end

      it "should find all episodes within the given season for a given show" do
        show = Bierdopje::Show.find 5517
        episodes = show.episodes(1)
        episodes.count.should == 24
        episodes.collect(&:code).should include('S01E01')
        episodes.collect(&:code).should_not include('S02E01')
      end
    end

    describe "#subtitles" do
      it "should find all subtitles within the given season for a given show" do
        show = Bierdopje::Show.find 5517
        subtitles = show.subtitles(1)
        subtitles.collect(&:file_name).should include('Lost.S01E01.DVDRip.XviD.AC3-UnSeeN.srt')
      end
    end
  end

  describe "#find" do
    it "should find the correct show based on the id" do
      show = Bierdopje::Show.find 5517
      show.id.should == '5517'
      show.tvdb_id.should == '73739'
      show.name.should == 'Lost'
    end
  end

  describe "find_by_tvdb_id" do
    it "should find the correct show on it's tvdb_id" do
      show = Bierdopje::Show.find_by_tvdb_id 73739
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

  describe "search" do
    it "should return all matches for the given search query" do
      shows = Bierdopje::Show.search 'Lost'
      shows.collect(&:id).should include('5517')
      shows.collect(&:tvdb_id).should include('73739')
      shows.collect(&:name).should include('Lost')
    end
  end
end
