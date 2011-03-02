module Bierdopje
  class Show < Base
    attr_accessor :id, :tvdb_id, :name

    def initialize doc
      attributes = {
        :id => doc.at_xpath('showid').content,
        :tvdb_id => doc.at_xpath('tvdbid').content,
        :name => doc.at_xpath('showname').content
      }
      super attributes
    end

    # Retrieve Episodes that belong to this Show.
    def episodes season=nil
      path = season ? "GetEpisodesForSeason/#{id}/#{season}" : "GetAllEpisodesForShow/#{id}"
      response = fetch path

      response.xpath('results/result').collect do |result|
        Episode.new(result)
      end
    end

    # Retrieve all Subtitles for the given season for this Show.
    # The season number is a required parameter.
    # You can pass the language as an option.
    # This either has to be +:nl+ (default) or +:en+.
    def subtitles season, language=:nl
      response = fetch "GetSubsForSeason/#{id}/#{season}/#{language}"
      response.xpath('results/result').collect do |result|
        Subtitle.new(result)
      end
    end

    class << self
      # Retrieve a Show based on it's id.
      def find id
        response = fetch "GetShowById/#{id}"
        Show.new response
      end

      # Retrieve a Show based on it's thetvdb.com id.
      def find_by_tvdb_id id
        response = fetch "GetShowByTVDBID/#{id}"
        Show.new response
      end

      # Retrieve a Show based on it's exact name.
      def find_by_name name
        response = fetch "GetShowByName/#{name}"
        Show.new response
      end

      # Searches for Shows based on it's name.
      def search query
        response = fetch "FindShowByName/#{query}"
        response.xpath('results/result').collect do |result|
          Show.new(result)
        end
      end
    end
  end
end
