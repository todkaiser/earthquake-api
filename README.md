# Earthquake API

A JSON web service that returns the most dangerous regions as measured by total measured earthquake energy in descending order.

## Pre-installation

- Assumptions: using Mac and Homebrew
- Note: For onboarding new developers, consider the [thoughtbot laptop script](https://github.com/thoughtbot/laptop)

#### Install versions of ruby
```
$ brew install ruby-build
$ brew install rbenv
$ rbenv install 2.4.1
```

---

## Install postgresql and redis
```
$ brew install postgresql
$ brew services start postgresql
$ brew install redis
$ brew services start redis
```

---

## Prepare rails app

Note: If I have given you access to the private repository, just clone the repo at `git@github.com:todkaiser/earthquake-api.git`

```
$ cd earthquake-api
$ gem install bundler
$ bundle install
```

#### Create databases

```
$ bin/rake db:create
```

#### Set the database environment to development

```
$ bin/rake db:environment:set RAILS_ENV=development
```

#### Load schema.rb file into the database

```
$ bin/rake db:schema:load
```

---

## Start rails app
To run the web server and background workers, install the following tool

```
$ gem install foreman
```

Next, run

```
$ foreman start -p 3000
```

#### Create earthquake records

A library called [geocoder](https://github.com/alexreisner/geocoder) is used to generate a human-readable street address based off coordinates - latitude and longitude. These fields - address, country, country_code, state, state_code - are then updated in each earthquake record. Unfortunately, the free version of this geocoding service uses Google APIs, which have strict quotas - __2,500 requests/24 hrs, 5 requests/second__.

For the purposes of this application and to stay below the quotas, run the below rake task. This rake task will import and save the past 7 days of USGS earthquake data. Pass an integer argument to set a limit to number of earthquake records created, e.g. below will create a maximum of 250 earthquake records.

```
$ bin/rake import_usgs_data:all_week[250]
```

Task should complete in ~5 min.

---

## API

To access the endpoint, go to

```
localhost:3000/regions
```

#### GET /regions?region_type=world

```

[
  {
    name: 'Papua New Guinea',
    total_magnitude: 6.33464784810176,
    earthquake_count: 3
  },
  {
    name: 'Russia',
    total_magnitude: 5.58709590900764,
    earthquake_count: 6
  },
  {
    name: 'Indonesia',
    total_magnitude: 5.43895954437267,
    earthquake_count: 3
  },

  ...
]
```

#### GET /regions?count=1

```
[
  {
    name: 'Papua New Guinea',
    total_magnitude: 6.33464784810176,
    earthquake_count: 3
  },
  {
    name: 'Russia',
    total_magnitude: 5.58709590900764,
    earthquake_count: 6
  }
]
```

#### GET /regions?region_type=state

```
[
  {
    name: 'Miyagi-ken',
    total_magnitude: 4.5,
    earthquake_count: 1
  },
  {
    name: 'Alaska',
    total_magnitude: 4.47942315179584,
    earthquake_count: 101
  },
  {
    name: 'Idaho',
    total_magnitude: 4.39142286776905,
    earthquake_count: 6
  },

  ...
]
```

#### GET /regions?region_type=world&region_code=JP

```
[
  {
    name: 'Japan',
    total_magnitude: 4.5,
    earthquake_count: 1
  }
]
```

#### GET /regions?region_type=state&region_code=CA

```
[
  {
    name: 'California',
    total_magnitude: 4.0201386902756,
    earthquake_count: 187
  }
]
```

## Task Scheduler

The application contains a job that pulls USGS earthquake data from the past hour every 15 minutes. To initiate this task, in the project directory run

```
$ bundle exec whenever --update-crontab --set environment=development
```

To check if the job is scheduled, run

```
$ crontab -l
```

You should see output similar to the following:

```sh
# Begin Whenever generated tasks for: /Users/todkaiser/Development/earthquake-api/config/schedule.rb at: 2018-02-01 18:51:00 -0800
0,5,10,15,20,25,30,35,40,45,50,55 * * * * /bin/bash -l -c 'cd /Users/todkaiser/Development/earthquake-api && RAILS_ENV=development bundle exec rake import_usgs_data:all_hour --silent >> /Users/todkaiser/Development/earthquake-api/log/chron.job 2>&1'

# End Whenever generated tasks for: /Users/todkaiser/Development/earthquake-api/config/schedule.rb at: 2018-02-01 18:51:00 -0800
```
#### Important

The cron job will continue running even if the web server is shut down. To remove the cron job, run

```
$ crontab -e
```

and delete the job.

---

## Rails console access

```
$ bin/rails console
```

---

## Running Tests

```
$ bin/rspec
```
