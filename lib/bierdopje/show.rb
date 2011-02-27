module Bierdopje
  class Show < Base
    def self.attributes_names
      [:id, :tvdb_id, :name]
    end
    attr_accessor *attributes_names

    def initialize doc
      attributes = {
        :id => doc.at_xpath('showid').content,
        :tvdb_id => doc.at_xpath('tvdbid').content,
        :name => doc.at_xpath('showname').content
      }
      super attributes
    end

    def episodes attributes={}
      response = if attributes[:season]
        Nokogiri::XML.parse(self.class.get("GetEpisodesForSeason/#{id}/1")).at_xpath('bierdopje/response')
      else
        Nokogiri::XML.parse(self.class.get("GetAllEpisodesForShow/#{id}")).at_xpath('bierdopje/response')
      end

      response.xpath('results/result').collect do |result|
        Episode.new(result)
      end
    end

    def subtitles season, language=:nl
      response = 
Nokogiri::XML.parse(self.class.get("GetSubsForSeason/#{id}/#{season}/#{language}")).at_xpath('bierdopje/response')
      response.xpath('results/result').collect do |result|
        Subtitle.new(result)
      end
    end

    class << self
      def find id
        response = Nokogiri::XML.parse(get("GetShowById/#{id}")).at_xpath('bierdopje/response')
        Show.new response
      end

      def find_by_tvdb_id id
        response = Nokogiri::XML.parse(get("GetShowByTVDBID/#{id}")).at_xpath('bierdopje/response')
        Show.new response
      end

      def find_by_name name
        response = Nokogiri::XML.parse(get("GetShowByName/#{name}")).at_xpath('bierdopje/response')
        Show.new response
      end

      def search query
        response = Nokogiri::XML.parse(get("FindShowByName/#{query}")).at_xpath('bierdopje/response')
        response.xpath('results/result').collect do |result|
          Show.new(result)
        end
      end
    end
  end
end
