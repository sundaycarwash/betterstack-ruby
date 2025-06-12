module BetterStack
  module Resources
    class Heartbeat < Base
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

      def pause(id)
        client.post("#{resource_path(id)}/pause")
      end

      def resume(id)
        client.post("#{resource_path(id)}/resume")
      end

      def ping(id, params = {})
        client.post("#{resource_path(id)}/ping", params)
      end

      def checks(id, params = {})
        client.get("#{resource_path(id)}/checks", params)
      end

      private

      def resource_name
        "heartbeats"
      end
    end
  end
end
