class EarthquakeRegions
  REGIONAL_COUNT = 10
  DAYS_BACK = 30
  COUNTRY_CODE = 'country_code'.freeze
  ADMIN_REGION = 'administrative_division'.freeze

  def initialize(count:, days:, region_type:)
    @count = count || REGIONAL_COUNT
    @days = days&.to_i || DAYS_BACK
    @region_type = region_type === ADMIN_REGION ? region_type : COUNTRY_CODE
  end

  def data
    {
      meta: {
        total_hits: query_earthquakes.length,
        region_type: @region_type
      },
      data: query_earthquakes
    }
  end

  private

  def query_earthquakes
    @_earthquakes ||= \
      Earthquake.where.not(@region_type => nil)
        .where(time: @days.days.ago..Time.current)
        .select(
          %[
            id,
            #{@region_type} AS name,
            SUM(magnitude) AS total_magnitude,
            COUNT(id) AS earthquake_count
          ]
        )
        .group(@region_type)
        .order('COUNT(id) DESC')
        .limit(@count)
  end
end