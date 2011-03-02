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
      response = Nokogiri::XML.parse(self.class.get(path)).at_xpath('bierdopje/response')

      response.xpath('results/result').collect do |result|
        Episode.new(result)
      end
    end

    # Retrieve all Subtitles for the given season for this Show.
    # The season number is a required parameter.
    # You can pass the language as an option.
    # This either has to be +:nl+ (default) or +:en+.
    def subtitles season, language=:nl
      response = 
Nokogiri::XML.parse(self.class.get("GetSubsForSeason/#{id}/#{season}/#{language}")).at_xpath('bierdopje/response')
      response.xpath('results/result').collect do |result|
        Subtitle.new(result)
      end
    end

    class << self
      # Retrieve a Show based on it's id.
      def find id
        response = Nokogiri::XML.parse(get("GetShowById/#{id}")).at_xpath('bierdopje/response')
        Show.new response
      end

      # Retrieve a Show based on it's thetvdb.com id.
      def find_by_tvdb_id id
        response = Nokogiri::XML.parse(get("GetShowByTVDBID/#{id}")).at_xpath('bierdopje/response')
        Show.new response
      end

      # Retrieve a Show based on it's exact name.
      def find_by_name name
        response = Nokogiri::XML.parse(get("GetShowByName/#{name}")).at_xpath('bierdopje/response')
        Show.new response
      end

      # Searches for Shows based on it's name.
      def search query
        response = Nokogiri::XML.parse(get("FindShowByName/#{query}")).at_xpath('bierdopje/response')
        response.xpath('results/result').collect do |result|
          Show.new(result)
        end
      end
    end
  end
end
