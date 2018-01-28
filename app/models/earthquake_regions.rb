class EarthquakeRegions
  DEFAULT_REGION_COUNT = 10
  DEFAULT_DAYS_BACK = 30
  DEFAULT_REGION_TYPE = 'country'.freeze
  DEFAULT_REGION_CODE = 'country_code'.freeze

  def initialize(count:, days:, region_type:, region_code:)
    @count = filter_count_param(count)
    @days = filter_days_param(days)
    @region_type = filter_region_type_param(region_type)
    @region_code = filter_region_code_param(region_code)
    @region_code_type = filter_region_code_type(@region_type)
  end

  def data
    query = Earthquake.where.not(@region_type => nil)
    query = query.where(@region_code_type => @region_code) if @region_code.present?
    query = query.where(time: @days.days.ago..Time.current)
    query.select(
      %[
        #{@region_type} AS name,
        LOG(SUM(POW(10,magnitude))) AS total_magnitude,
        COUNT(id) AS earthquake_count
      ]
    ).group(@region_type).order('total_magnitude DESC').limit(@count)
  end

  private

  def filter_count_param(count)
    count.blank? ? DEFAULT_REGION_COUNT : count.to_i
  end

  def filter_days_param(days)
    days.blank? ? DEFAULT_DAYS_BACK : days.to_i
  end

  def filter_region_type_param(region_type)
    case region_type&.downcase
    when 'world'
      'country'
    when 'state'
      'state'
    else
      DEFAULT_REGION_TYPE
    end
  end

  def filter_region_code_param(region_code)
    region_code&.upcase if region_code.present?
  end

  def filter_region_code_type(region_type)
    case region_type&.downcase
    when 'country'
      'country_code'
    when 'state'
      'state_code'
    else
      DEFAULT_REGION_CODE
    end
  end
end
