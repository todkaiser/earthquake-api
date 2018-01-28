class EarthquakeRegions
  DEFAULT_REGION_COUNT = 10
  DEFAULT_DAYS_BACK = 30
  DEFAULT_REGION_TYPE = 'country'.freeze

  def initialize(count:, days:, region_type:)
    @count = filter_count_param(count)
    @days = filter_days_param(days)
    @region_type = filter_region_type_param(region_type)
  end

  def data
    @_earthquakes ||= \
      Earthquake.where.not(@region_type => nil)
        .where(time: @days.days.ago..Time.current)
        .select(
          %[
            #{@region_type} AS name,
            LOG(SUM(POW(10,magnitude))) AS total_magnitude,
            COUNT(id) AS earthquake_count
          ]
        )
        .group(@region_type)
        .order('total_magnitude DESC')
        .limit(@count)
  end

  private

  def filter_count_param(count)
    count.blank? ? DEFAULT_REGION_COUNT : count.to_i
  end

  def filter_days_param(days)
    days.blank? ? DEFAULT_DAYS_BACK : days.to_i
  end

  def filter_region_type_param(region_type)
    case region_type
    when 'world'
      'country'
    when 'state'
      'state'
    else
      DEFAULT_REGION_TYPE
    end
  end
end
