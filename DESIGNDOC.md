# Describe how you would improve upon your current design.

### Route changes

I think adding a few more endpoints might be more expressive than a bunch of ambiguous query parameters. Some ideas:

```
GET /grouped_regions?states[]=CA&states[]=AK
```

```
GET /grouped_regions?country[]=USA&country[]=JP
```

### Response schema changes

I think the response should contain more fields. There are only three fields being returned, e.g.

```
[
  {
    name: 'Alaska',
    total_magnitude: 4.47942315179584,
    earthquake_count: 101
  }
]
```

To me, it would be more useful if the response looked like this:

```
{
  meta: {
    grouped_by: 'state',
    country_code: 'US',
    order: 'desc',
    from: 2018/1/1,
    to: 2018/1/29,
    total_grouped_regions: 4,
    limit: 10
  },
  data: {
    [
      {
        name: 'Alaska',
        country: 'United States'
        grouped_by: 'state',
        total_magnitude: 4.47942315179584,
        tsunami_count: 2,
        earthquake_count: 101
      }
    ],
    {
      ...
    }
  }
}
```

This response provides more meaningful information. The `meta` object reminds me what grouping I'm using, there is a count of grouped regions as well as the order. The `limit` param takes over for `count`. Basically, the query param filters are contained within the meta. Additionally, the actual data of the grouped earthquake regions will be under the `data` object, as well as serialized aspects of the model providing more useful information about the region in question.

### Using a microframework

I used Rails (rails-api) to build this web service because I know it well and I feel very productive prototyping anything in it. It's the first tool I reach for. With that said, it may be overkill as a solution. An alternative could have used a microframework like Sinatra.

---

# Why did you choose the region definition you did? What other definitions did you consider and what are the pros/cons of each approach?

### timezone

Timezone is a less meaningful definition with regard to determining the most dangerous earthquake regions. It isn't intuitive in visualizing a distinct geographical region. While we may be familiar with the geography of the region within our timezone, we need to bear in mind that timezone includes _both_ hemispheres. That's a huge surface area and isn't specific. It's simply not intuitive when identifying a region.

### tsunami

At first I thought maybe tsunami might work. The effects can certainly be catastrophic, so they definitely qualify as a danger. If there is a tsunami warning then we know that an earthquake triggered close to a coast. But, there is a lot of coastal area in the world. Again, not specific enough.


### world & state
I eventually went with two region type definitions: __world__ and __state__.

With world, clustering is by country. This is more meaningful because we can see if a certain country has suffered the most from total magnitude. While there is huge variance between the geographic size of countries - the larger ones like Russia, US, and China losing specificity - it is still informative because is brings a distinct place in mind.

The other region type is state, which is really an alias for an administrative division within a country. This can comprise of states like California in the United States, prefectures like Miyagi in Japan, and provinces like British Columbia in Canada, and many more. This clustering is useful, especially for more granular searches. The downside is because by default states aren't scope to any particular country (region_code somewhat takes care of this), we can get a situation where the search is too specific, especially if they are names of other states that aren't familiar (outside of US / CA).

---

# In order to get this server ready for production, what would your next steps be? Is there anything you'd change about the design?

### Task Scheduler

The first thing would be to schedule - via a background processing tool like Sidekiq or as a crontab -  two of the following rake tasks:
- `import_usgs_data:all_day`
- `geocode:all`

The first step would be to run the rake task `import_usgs_data:all_month` just once in a production console to be    create earthquake records. After this is done, `geocode:all` should be run repeatedly until all records have been reverse geocoded.

At this point, there is a business decision to be made that determines just how real-time the data needs to be. If it is very important for the database to be be most up-to-date, I recommend actually not using the "All Month 30 days past" endpoint for updates due to the sheer size of the file. This is seems wasteful too as we'll already have the majority of the records if, say, we're updating at every 15 minutes (the update interval reported by USGS).

A little exploring of the USGS website revealed an endpoint that fetches all earthquakes reported in the past day (updated every 5 minutes). This is nice because the response object is significantly smaller which means less objects to parse through and insert into the database, response times are expected to be faster as USGS servers are expected to work less hard, and the updates are just happening 3X faster than the all month version.

### Caching

Many repeated requests to the same endpoint can be resource intensive. Currently the application only performs 1 SQL query, but again, if you're trying to be as efficient as possible, caching server responses is a good solution.

### Authentication & API Key

We need to find a way to guard against any malicious actors aiming for a DOS. Proper rate limits need to be set, especially for free versions. Additionally, authentication via API keys should be considered for increased rate limits and quotas. Again, this really depends on the goals of the business. Whatever is decided though, the issue of authenticated vs unauthenticated access needs to be figured out before deploying.

### Security

If it's feasible, the company should strongly consider a bug bounty program. The web service can be deployed as an alpha and undergo some pentesting from a select pool of invited researchers. This is a great way to quickly identify any security bugs that may have leaked through the development process at a fraction of the cost going with traditional pentest vendors or through the pains of leaked confidential data, PR nightmares, etc.

### ENV production

Currently the project has no configuration for a production environment. Once the means of deploying is figured out, then all these ENV settings will need to be determined.

### Deployment

This is an area that I don't have very much hands-on experience in other than the automated approach of deploying Rack-based apps to Heroku. But, what seems to be a really popular approach now is to use containerization via Docker. I've only used Docker briefly when I was trying to overcome some configuration issues in my local environment, but it may be worth investing in bringing a reliable environment to production.

Another area worth exploring is Heroku vs EC2. This probably depends on how to scale the business, but from what I've seen at places I've worked at, it was very easy to get started with Heroku. But over time, as the business and applications expanded, there was a need to have more control over infrastructure as well as reduce costs. EC2 seems to solve this well.
