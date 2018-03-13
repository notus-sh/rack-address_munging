# frozen_string_literal: true

describe Rack::AddressMunging::Strategy::Rot13JS do
  let(:samples) { load_data('strategy')['samples'] }

  it 'replaces address with a JS encoded version' do
    samples.each do |sample|
      source = ::Rack::Response.new([sample['source']])
      munged = ::Rack::Response.new

      subject.apply(munged, source)
      expect(munged.body.first).to eq(sample['result']['rot13js'])
    end
  end
end
