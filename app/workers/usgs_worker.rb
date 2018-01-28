class UsgsWorker
  include Sidekiq::Worker

  def perform(*_args)
    earthquakes = EarthquakeService.new.data['features']
    earthquakes.each do |e|
      properties = e['properties']
      coordinates = e['geometry']['coordinates']
      longitude = coordinates.first
      latitude = coordinates.second

      result = Earthquake.find_or_create_by(usgs_id: e['id']) do |quake|
        quake.magnitude = properties['mag']
        quake.longitude = longitude
        quake.latitude = latitude
        quake.tsunami = properties['tsunami']
        quake.title = properties['title']
        quake.time = to_datetime(properties['time'])
      end

      if result
        puts "Create earthquake record: #{result.usgs_id}"
      else
        raise RuntimeError "Earthquake failed to update: #{result.id}"
      end
    end
  end

  private

  def to_datetime(timestamp)
    Time.at(timestamp / 1000).utc.to_datetime
  end
end
