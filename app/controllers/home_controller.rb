class HomeController < ApplicationController
  def index
    render json: {status: 'SUCCESSFUL', message: 'Rails API is working'}, status: :ok
  end
end
