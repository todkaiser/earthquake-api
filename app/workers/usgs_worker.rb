class UsgsWorker
  include Sidekiq::Worker

  def perform(*args)
    earthquakes = EarthquakeService.new.data['features'][0, 10]

    earthquakes.each do |e|
      properties = e[:properties]
      coordinates = e[:geometry][:coordinates]
      longitude = coordinates.first
      latitude = coordinates.second

      record = Earthquake.find_or_create_by(usgs_id: e.id)
      record.update_attributes(
        magnitude: properties[:mag],
        longitude: longitude,
        latitude: latitude,
        region_type: parse_for_state(latitude, longitude),
        title: properties[:title],
        time: properties[:time].
      )
    end
  end

  private

  def parse_for_state(latitude, longitude)
     geo_localization = "#{latitude},#{longitude}"
     query = Geocoder.search(geo_localization).first
     query.state
  end
end
