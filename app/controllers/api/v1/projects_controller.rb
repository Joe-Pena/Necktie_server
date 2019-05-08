module Api 
  module V1
    class ProjectsController < ApplicationController
      def index
        @projects = Project.all

        render json: {status: 'SUCCESS', message: 'Projects retrieved', data: @projects.sort}, status: :ok
      end

      def show
        @project = Project.find(params[:id])

        render json: {status: 'SUCCESS', message: 'Project found', data: @project}, status: :ok
      end

      def create
        @project = Project.new(project_params)

        if @project.save
          render json: {status: 'CREATED', message: 'Created project', data: @project}, status: :created
        else
          render json: {status: 'ERROR', message: 'Unable to create', data: @project.errors}, status: :unprocessable_entity
        end
      end

      def update
        @project = Project.find(params[:id])

        if @project.update_attributes(project_params)
          render json: {status: 'SUCCESS', message: 'Project updated', data: @project}, status: :accepted
        else
          render json: {status: 'ERROR', message: 'Project not updated', data: @project.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @project = Project.find(params[:id])

        if @project.destroy
          render json: {status: 'DELETED', message: 'Project deleted', data: @project}, status: :no_content
        else
          render json: {status: 'ERROR', message: 'Unable to delete item', data: @project.errors}, status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.require(:project).permit(:name, :done, :todos_id)
      end
    end
  end
end