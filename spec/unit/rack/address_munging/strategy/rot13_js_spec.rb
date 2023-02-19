# frozen_string_literal: true

describe Rack::AddressMunging::Strategy::Rot13JS do
  subject(:strategy) { described_class.new }

  let(:samples) { load_fixtures('strategy')['samples'] }

  it 'replaces address with a JS encoded version' do
    samples.each do |sample|
      munged = Rack::Response.new
      strategy.apply(munged, Rack::Response.new([sample['source']]))

      expect(munged.body.first).to eq(sample['result']['rot13js'])
    end
  end
end
