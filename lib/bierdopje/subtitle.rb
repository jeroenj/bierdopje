module Bierdopje
  class Subtitle < Base
    attr_accessor :file_name, :file_size, :uploaded_at, :link

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
      # Retrieve a Subtitle based on Show id, season number and episode number.
      # You can pass the language as an option.
      # This either has to be +:nl+ (default) or +:en+.
      def find show_id, season_number, episode_number, language=:nl
        response = fetch "GetAllSubsFor/#{show_id}/#{season_number}/#{episode_number}/#{language}"
        response.xpath('results/result').collect do |result|
          Subtitle.new(result)
        end
      end
    end
  end
end
