module Api
  module V1
    class TodosController < ApplicationController
      include CurrentUserConcern

      before_action :authenticate_user

      def index
          @todos = Todo.all
          render json: {status: 'SUCCESS', message: 'Todo list retrieved', data: @todos}, status: :ok
      end

      def show
        @todo = Todo.find(params[:id])

        render json: {status: 'SUCCESS', message: 'Todo found', data: @todo}, status: :ok
      end

      def create
          @todo = Todo.new(todo_params)

          @todo.save
          render json: @todo, status: :created
      end

      def update
        @todo = Todo.find(params[:id])

        if @todo.update_attributes(todo_params)
          render json: {status: 'SUCCESS', message: 'Todo updated', data: @todo}, status: :accepted
        else
          render json: {status: 'ERROR', message: 'Todo not updated', data: @todo.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @todo = Todo.find(params[:id])

        if @todo.destroy
          render json: {status: 'DELETED', message: 'Todo deleted', data: @todo}, status: :no_content
        else
          render json: {status: 'ERROR', message: 'Unable to delete item', data: @todo.errors}, status: :unprocessable_entity
        end
      end

      private

      def todo_params
        params.require(:todo).permit(:name, :done, :project_id)
      end

      def authenticate_user
        if !@current_user
          render json: {status: 'UNAUTHORIZED', message: 'User not logged in'}, status: :unauthorized
        end
      end
    end
  end
end