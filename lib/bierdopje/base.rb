module Bierdopje
  class Base
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
      protected
      def fetch path
        parse(path).at_xpath('bierdopje/response')
      end

      def parse path
        response = RestClient.get "http://api.bierdopje.com/AD1E97978FD73FB3/#{path}"
        Nokogiri::XML.parse response
      end
    end
  end
end
