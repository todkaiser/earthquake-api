require 'spec_helper'

describe EarthquakeRegions, type: :model do
  let!(:quake_1) { create :earthquake, magnitude: 3, country_code: 'JP', country: 'Japan' }
  let!(:quake_2) { create :earthquake, magnitude: 1, country_code: 'JP', country: 'Japan' }

  let!(:quake_3) do
    create :earthquake, magnitude: 2, state: 'Alaska', state_code: 'AK', country_code: 'US',
                        country: 'United States'
  end

  let!(:quake_4) do
    create :earthquake, magnitude: 1, state: 'California', state_code: 'CA', country_code: 'US',
                        country: 'United States'
  end

  let!(:quake_5) do
    create :earthquake, magnitude: 1, state: 'California', state_code: 'CA', country_code: 'US',
                        country: 'United States'
  end

  let(:total_magnitude_japan) { 3.00432137378264 } # Math.log10(10**1 + 10**3)
  let(:total_magnitude_usa) { 2.07918124604762 } # Math.log10(10**1 + 10**1 + 10**2)
  let(:total_magnitude_california) { 1.30102999566398 } # Math.log10(10**1 + 10**1)

  describe '#data' do
    context 'with world region type' do
      subject { described_class.new(params).data.as_json(except: :id) }

      let(:params) { { count: '', days: '', region_type: '', region_code: '' } }
      let(:result) do
        [
          { name: 'Japan', total_magnitude: total_magnitude_japan, earthquake_count: 2 },
          { name: 'United States', total_magnitude: total_magnitude_usa, earthquake_count: 3 }
        ]
      end

      it { is_expected.to eq(result.as_json) }
    end

    context 'with state region type' do
      subject { described_class.new(params).data.as_json(except: :id) }

      let(:params) { { count: '', days: '', region_type: 'state', region_code: '' } }
      let(:result) do
        [
          { name: 'Alaska', total_magnitude: 2, earthquake_count: 1 },
          { name: 'California', total_magnitude: total_magnitude_california, earthquake_count: 2 }
        ]
      end

      it { is_expected.to eq(result.as_json) }
    end
  end
end
