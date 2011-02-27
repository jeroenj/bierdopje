module Bierdopje
  class Subtitle < Base
    def self.attributes_names
      [:file_name, :file_size, :uploaded_at, :link]
    end
    attr_accessor *attributes_names

    def initialize doc
      attributes = {
        :file_name => doc.at_xpath('filename').content,
        :file_size => doc.at_xpath('filesize').content,
        :uploaded_at => doc.at_xpath('pubdate').content,
        :link => doc.at_xpath('downloadlink').content
      }
      super attributes
    end

    class << self
      def find show_id, season_number, episode_number, language=:nl
        response = Nokogiri::XML.parse(get("GetAllSubsFor/#{show_id}/#{season_number}/#{episode_number}/#{language}")).at_xpath('bierdopje/response')
        response.xpath('results/result').collect do |result|
          Subtitle.new(result)
        end
      end
    end
  end
end
