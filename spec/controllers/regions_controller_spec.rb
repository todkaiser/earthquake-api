require 'spec_helper'

describe RegionsController, type: :controller do
  describe '#index' do
    it 'responds 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
