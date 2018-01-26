class RegionsController < ApplicationController
  def index
    @earthquakes = Earthquake.all
    render json: @earthquakes
  end
end
