# frozen_string_literal: true

describe Rack::AddressMunging::Strategy::Hex do
  subject(:strategy) { described_class.new }

  let(:samples) { load_fixtures('strategy')['samples'] }

  it 'replaces address with an hex encoded version' do
    samples.each do |sample|
      munged = Rack::Response.new
      strategy.apply(munged, Rack::Response.new([sample['source']]))

      expect(munged.body.first).to eq(sample['result']['hex'])
    end
  end
end
