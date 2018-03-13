# frozen_string_literal: true

describe Rack::AddressMunging::Strategy::Hex do
  let(:samples) { load_data('strategy')['samples'] }

  it 'replaces address with an hex encoded version' do
    samples.shuffle.each do |sample|
      source = ::Rack::Response.new([sample['source']])
      munged = ::Rack::Response.new

      subject.apply(munged, source)
      expect(munged.body.first).to eq(sample['result']['hex'])
    end
  end
end
