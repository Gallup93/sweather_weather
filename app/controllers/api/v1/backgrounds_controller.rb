class Api::V1::BackgroundsController < ApplicationController
  def index
    object = CompileBackground.new(params[:location])
    render json: object.url
  end
end
