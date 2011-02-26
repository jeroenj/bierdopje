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

    def episodes
      response = Nokogiri::XML.parse(self.class.get("GetAllEpisodesForShow/#{id}")).at_xpath('//response')

      response.xpath('results//result').collect do |result|
        Episode.new(result)
      end
    end

    class << self
      def find id
        response = Nokogiri::XML.parse(get("GetShowById/#{id}")).at_xpath('//response')
        Show.new response
      end

      def find_by_tvdb_id id
        response = Nokogiri::XML.parse(get("GetShowByTVDBID/#{id}")).at_xpath('//response')
        Show.new response
      end

      def find_by_name name
        response = Nokogiri::XML.parse(get("GetShowByName/#{name}")).at_xpath('//response')
        Show.new response
      end
    end
  end
end
