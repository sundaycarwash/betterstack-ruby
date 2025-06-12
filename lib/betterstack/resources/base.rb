module BetterStack
  module Resources
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      private

      def resource_path(id = nil)
        path = "#{resource_name}"
        path += "/#{id}" if id
        path
      end

      def resource_name
        self.class.name.split("::").last.downcase + "s"
      end
    end
  end
end
