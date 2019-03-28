require 'spec_helper'

RSpec.describe Functions::Health, type: :controller do
  let(:subject) { Functions::Health }

  describe 'call' do
    it 'returns success response' do
      expect(subject.call({}, {})[:statusCode]).to eq(200)
    end
  end
end
