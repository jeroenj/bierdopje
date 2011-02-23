module Bierdopje
  class Base
    def initialize attributes = {}
      attributes.keys.each do |key|
        self.send "#{key}=", attributes[key]
      end
    end

    class << self
      def get path
        RestClient.get "http://api.bierdopje.com/AD1E97978FD73FB3/#{path}"
      end
    end
  end
end
