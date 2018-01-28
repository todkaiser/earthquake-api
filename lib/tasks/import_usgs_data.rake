desc 'Imports USGS earthquake data once per day'
task import_usgs_data: :environment do
  puts 'Begin importing USGS data'
  UsgsWorker.new.perform
  puts 'done'
end
