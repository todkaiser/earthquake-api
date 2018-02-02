namespace :import_usgs_data do
  desc 'Imports all USGS earthquake data for past hour'
  task all_hour: :environment do
    puts 'Begin importing USGS data for past hour'
    UsgsWorker.new.perform('hour')
    puts 'done'
  end

  desc 'Imports all USGS earthquake data for past day'
  task all_day: :environment do
    puts 'Begin importing USGS earthquake data for past day'
    UsgsWorker.new.perform('day')
    puts 'done'
  end

  desc 'Imports all USGS earthquake data for past 7 days'
  task all_week: :environment do
    puts 'Begin importing USGS data for past 7 days'
    UsgsWorker.new.perform('week')
    puts 'done'
  end

  desc 'Imports all USGS earthquake data for past 30 days'
  task all_month: :environment do
    puts 'Begin importing USGS data for past 30 days'
    UsgsWorker.new.perform('month')
    puts 'done'
  end
end
