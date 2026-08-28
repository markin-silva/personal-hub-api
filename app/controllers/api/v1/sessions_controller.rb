module Api
  module V1
    class SessionsController < Devise::SessionsController
      def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource, store: false)
        render json: {
          message: "Logged in successfully.",
          user: resource
        }, status: :ok
      end

      private

      def auth_options
        { scope: resource_name, recall: "#{controller_path}#new" }
      end
    end
  end
end
