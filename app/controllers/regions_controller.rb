class RegionsController < ApplicationController
  def index
    @earthquakes = usa_earthquakes
    render json: @earthquakes
  end

  def usa_earthquakes
    quakes = Earthquake.where(country_code: 'US').where.not(admin_region: nil)
    quakes.group(:admin_region).count
  end
end
