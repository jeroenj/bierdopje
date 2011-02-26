module Bierdopje
  class Episode < Base
    def self.attributes_names
      [:id, :code, :show_name]
    end
    attr_accessor *attributes_names

    def show
      Show.find_by_name show_name
    end

    def initialize doc
      attributes = {
        :id => doc.at_xpath('episodeid').content,
        :code => doc.at_xpath('formatted').content,
        :show_name => doc.at_xpath('showlink').content.match(/^http:\/\/www\.bierdopje\.com\/shows\/(.*)$/)[1]
      }
      super attributes
    end

    class << self
      def find id
        response = Nokogiri::XML.parse(get("GetEpisodeById/#{id}")).at_xpath('bierdopje/response/results')
        Episode.new response
      end
    end
  end
end
