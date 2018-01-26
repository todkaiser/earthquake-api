class EarthquakeService

  attr_reader :data

  def initialize
    @data = external_usgs_api
  end

  private

  def external_usgs_api
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    body = RestClient.get(url)
    JSON.parse(body)
  end
end
