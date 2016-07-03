class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id])
    render layout: !request.xhr?
  end
end
