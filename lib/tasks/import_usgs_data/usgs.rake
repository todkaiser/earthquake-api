namespace :import_usgs_data do
  desc 'Imports all USGS earthquake data for past hour'
  task :all_hour, %i[limit] => :environment do |_task, args|
    puts 'Begin importing USGS data for past hour'
    UsgsWorker.new.perform('hour', args[:limit])
    puts 'done'
  end

  desc 'Imports all USGS earthquake data for past day'
  task :all_day, %i[limit] => :environment do |_task, args|
    puts 'Begin importing USGS earthquake data for past day'
    UsgsWorker.new.perform('day', args[:limit])
    puts 'done'
  end

  desc 'Imports all USGS earthquake data for past 7 days'
  task :all_week, %i[limit] => :environment do |_task, args|
    puts 'Begin importing USGS data for past 7 days'
    UsgsWorker.new.perform('week', args[:limit])
    puts 'done'
  end

  desc 'Imports all USGS earthquake data for past 30 days'
  task :all_month, %i[limit] => :environment do |_task, args|
    puts 'Begin importing USGS data for past 30 days'
    UsgsWorker.new.perform('month', args[:limit])
    puts 'done'
  end
end
