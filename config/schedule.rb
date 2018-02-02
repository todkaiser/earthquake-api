set :output, "#{path}/log/chron.job"

every 5.minutes do
  rake 'import_usgs_data:all_hour'
end
