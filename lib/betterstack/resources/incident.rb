module BetterStack
  module Resources
    class Incident < Base
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

      def resolve(id, message = nil)
        body = message ? { message: message } : {}
        client.post("#{resource_path(id)}/resolve", body)
      end

      def add_update(id, update_attributes)
        client.post("#{resource_path(id)}/incident_updates", update_attributes)
      end

      def updates(id, params = {})
        client.get("#{resource_path(id)}/incident_updates", params)
      end

      def update_incident_update(id, update_id, attributes)
        client.patch("#{resource_path(id)}/incident_updates/#{update_id}", attributes)
      end

      def delete_incident_update(id, update_id)
        client.delete("#{resource_path(id)}/incident_updates/#{update_id}")
      end

      private

      def resource_name
        "incidents"
      end
    end
  end
end
