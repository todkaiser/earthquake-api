class UsgsService
  attr_reader :data

  def initialize(time_range)
    @data = external_api(time_range)
  end

  private

  def external_api(time_range)
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_#{time_range}.geojson"
    body = RestClient.get(url)
    JSON.parse(body)
  end
end
