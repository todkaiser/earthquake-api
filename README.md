# Earthquake API

A webservice that returns the most dangerous regions as measured by total measured earthquake energy in descending order as  documents.

## Pre-installation

- Assumptions: using Mac and homebrew
- Note: For onboarding new developers, consider the [thoughtbot laptop script](https://github.com/thoughtbot/laptop)

#### Install versions of ruby
```
brew install ruby-build
```

```
brew install rbenv
```

```
rbenv install 2.4.1
```

---

## Install postgresql and redis
```
brew install postgresql
```

```
brew services start postgresql
```

```
brew install redis
```

```
brew services start redis
```

---

## Prepare rails app

Note: If I have given you access to the private repository, just clone the repo at `git@github.com:todkaiser/earthquake-api.git`

```
cd earthquake-api
```

```
gem install bundler
```

```
bundle install
```

#### Run database migration
```
bin/rake db:migrate
```

---

## Seeding earthquake data

```
bundle exec sidekiq
```

#### Create earthquake records
This rake task will import and save the past 30 days of USGS earthquake data

```
bin/rake import_usgs_data:all_month
```

#### Reverse geocoding
A library called [geocoder](https://github.com/alexreisner/geocoder) is used to generate a human-readable region type of based off earthquake coordinates. This process involves running another rake task. Unfortunately, the underlying free default geocoding service uses Google APIs, which have strict quotas - __2,500 requests/24 hrs, 5 requests/second__. As such, to stay below the quota, run the following rake task with `LIMIT` set to well below the quota limit. Set `SLEEP` to 0.25 ms to avoid being throttled.
```
bin/rake geocode:all REVERSE=true CLASS=Earthquake SLEEP=0.25 BATCH=100 LIMIT=500
```

---

## API

#### Start web server
```
bin/rails server
```

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

---

## Rails console access

```
bin/rails console
```

---

## Running Tests

```
bin/rspec
```
