Geocoder.configure(
  lookup: :google,
  timeout: 5,
  units: :km,
  cache: Redis.new
)
