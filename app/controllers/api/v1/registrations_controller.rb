module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      def create
        build_resource(sign_up_params)

        if resource.save
          sign_in(resource_name, resource, store: false)
          render json: {
            message: "Signed up successfully.",
            user: resource
          }, status: :ok
        else
          clean_up_passwords resource
          set_minimum_password_length
          render json: {
            errors: resource.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
