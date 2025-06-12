module BetterStack
  module Resources
    class Monitor < Base
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

      def response_times(id, params = {})
        client.get("#{resource_path(id)}/response-times", params)
      end

      def availability(id, params = {})
        client.get("#{resource_path(id)}/availability", params)
      end

      def test(attributes)
        client.post("/monitors/test", attributes)
      end

      private

      def resource_name
        "monitors"
      end
    end
  end
end
