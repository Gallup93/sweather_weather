class Api::V1::BackgroundsController < ApplicationController
  def index
    image_object = UnsplashServices.new.image_by_keyword(params[:location])
    render json: get_url(image_object)
  end

  private

  def get_url(image_object)
    types = [:regular, :small, :thumb]
    keys = image_object[:urls].keys
    url = {:url => nil}
    i = 0

    keys.each do |key|
      if key = types[i]
        url[:url] = image_object[:urls][key]
      end
    end
    url
  end
end
