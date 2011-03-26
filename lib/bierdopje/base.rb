module Bierdopje
  class Base
    @@api_key = nil

    def initialize attributes = {}
      attributes.keys.each do |key|
        self.send "#{key}=", attributes[key]
      end
    end

    protected
    def fetch path
      self.class.send :fetch, path
    end

    class << self
      def api_key
        @@api_key
      end

      def api_key= api_key
        @@api_key = api_key
      end

      protected
      def fetch path
        parse(path).at_xpath('bierdopje/response')
      end

      def parse path
        response = RestClient.get "http://api.bierdopje.com/#{api_key}/#{path}"
        Nokogiri::XML.parse response
      end
    end
  end
end
