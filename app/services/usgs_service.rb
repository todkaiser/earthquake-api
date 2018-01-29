class UsgsService
  attr_reader :data

  def initialize(time_range = 'month')
    @data = external_api filter_time_range(time_range)
  end

  private

  def filter_time_range(time_range)
    time_range == 'day' ? time_range : 'month'
  end

  def external_api(time_range)
    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_#{time_range}.geojson"
    body = RestClient.get(url)
    JSON.parse(body)
  end
end
