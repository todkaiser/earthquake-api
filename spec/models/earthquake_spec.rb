require 'spec_helper'

describe Earthquake, type: :model do
  subject { described_class.new }

  before { allow_any_instance_of(described_class).to receive(:reverse_geocode).and_return(nil) }

  it 'is valid with valid attributes' do
    subject.usgs_id = 'nc72959026'
    subject.magnitude = 0.98
    subject.longitude = -122.5268333
    subject.latitude = 37.7015
    subject.tsunami = 0
    subject.title = 'M 1.0 - 4km SSW of San Francisco Zoo, CA'
    subject.time = Time.at(1_517_004_553_160 / 1000).utc.to_datetime

    expect(subject).to be_valid
  end
end
