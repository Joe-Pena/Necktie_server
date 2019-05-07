module Api 
  module V1
    class SessionsController < ApplicationController
      include CurrentUserConcern

      def create
        @user = User
                  .find_by(username: params["user"]["username"])
                  .try(:authenticate, params["user"]["password"])

        if @user
          session[:user_id] = @user_id
          render json: {
            status: 'SUCCESS',
            logged_in: true,
            user: @user
          }, status: :created
        else
          render json: {status: 'UNAUTHORIZED'}, status: :unauthorized
        end
      end

      def logged_in
        if @current_user
          render json: { logged_in: true, user: @current_user }
        else
          render json: { logged_in: false }
        end
      end

      def logout
        reset_session
        render json: { status: :ok, logout: true }
      end

      def logout

      end
    end
  end
end