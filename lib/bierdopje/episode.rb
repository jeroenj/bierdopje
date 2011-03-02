module Bierdopje
  class Episode < Base
    attr_accessor :id, :season, :episode, :code, :title, :summary, :air_date, :show_name

    # Retrieve the Show this Episode belongs to.
    def show
      Show.find_by_name show_name
    end

    # Retrieve all Subtitles for this Episode.
    # You can pass the language as an option.
    # This either has to be +:nl+ (default) or +:en+.
    def subtitles language=:nl
      response = fetch "GetAllSubsForEpisode/#{id}/#{language}"
      response.xpath('results/result').collect do |result|
        Subtitle.new(result)
      end
    end

    def initialize doc
      attributes = {
        :id => doc.at_xpath('episodeid').content,
        :season => doc.at_xpath('season').content,
        :episode => doc.at_xpath('episode').content,
        :code => doc.at_xpath('formatted').content,
        :title => doc.at_xpath('title').content,
        :summary => doc.at_xpath('summary').content,
        :air_date => doc.at_xpath('airdate').content,
        :show_name => doc.at_xpath('showlink').content.match(/^http:\/\/www\.bierdopje\.com\/shows\/(.*)$/)[1]
      }
      super attributes
    end

    class << self
      # Retrieve an Episode based on it's id.
      def find id
        response = parse("GetEpisodeById/#{id}").at_xpath('bierdopje/response/results')
        Episode.new response
      end
    end
  end
end
