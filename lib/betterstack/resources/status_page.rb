module BetterStack
  module Resources
    class StatusPage < Base
      def list(params = {})
        client.get(resource_path, params)
      end

      def get(id)
        client.get(resource_path(id))
      end

      def create(attributes)
        client.post(resource_path, attributes)
      end

      def update(id, attributes)
        client.patch(resource_path(id), attributes)
      end

      def delete(id)
        client.delete(resource_path(id))
      end

      def resources(id, params = {})
        client.get("#{resource_path(id)}/resources", params)
      end

      def add_resource(id, resource_attributes)
        client.post("#{resource_path(id)}/resources", resource_attributes)
      end

      def update_resource(id, resource_id, attributes)
        client.patch("#{resource_path(id)}/resources/#{resource_id}", attributes)
      end

      def remove_resource(id, resource_id)
        client.delete("#{resource_path(id)}/resources/#{resource_id}")
      end

      def subscribers(id, params = {})
        client.get("#{resource_path(id)}/subscribers", params)
      end

      def add_subscriber(id, subscriber_attributes)
        client.post("#{resource_path(id)}/subscribers", subscriber_attributes)
      end

      def remove_subscriber(id, subscriber_id)
        client.delete("#{resource_path(id)}/subscribers/#{subscriber_id}")
      end

      private

      def resource_name
        "status-pages"
      end
    end
  end
end
