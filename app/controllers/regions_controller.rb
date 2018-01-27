class RegionsController < ApplicationController
  before_action :set_earthquake_regions, only: %i[index]

  def index
    render json: @earthquake_regions.as_json
  end

  private

  def filter_params
    params.permit(
      :count,
      :days,
      :region_type
    )
  end

  def set_earthquake_regions
    @earthquake_regions = EarthquakeRegions.new({
      count: filter_params[:count],
      days: filter_params[:days],
      region_type: filter_params[:region_type]
    }).query_earthquakes
  end
end
