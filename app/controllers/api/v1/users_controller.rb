module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all

        render json: {status: 'SUCCESS', message: 'Users found', data: @users}, status: :ok
      end

      def show 
        @user = User.find(params[:id])

        render json: {status: 'SUCCESS', message: 'User found', data: @user}, status: :ok
      end

      def create
        @user = User.new(user_params)

        if @user.save
          session[:user_id] = @user.id
          render json: {status: 'CREATED', message: 'User created', data: @user}, status: :created
        else
          render json: {status: 'ERROR', message: 'User not created', data: @user.errors}, status: :unprocessable_entity
        end
      end

      def update
        @user = User.find(params[:id])

        if @user.update_attributes(user_params)
          render json: {status: 'SUCCESS', message: 'User updated', data: @user}, status: :accepted
        else
          render json: {status: 'ERROR', message: 'User not updated', data: @user.errors}, status: :unprocessable_entity
        end

      end

      def destroy
        @user = User.find(params[:id])

        if @user.destroy
          render json: {status: 'DELETED', message: 'User deleted', data: @user}, status: :no_content
        else
          render json: {status: 'ERROR', message: 'User not deleted', data: @user.errors}, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end

    end
  end
end
