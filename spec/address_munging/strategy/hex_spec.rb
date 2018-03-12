# frozen_string_literal: true

describe Rack::AddressMunging::Strategy::Hex do
  let(:hex) { YAML.load_file('spec/data/hex.yml')['hex'] }

  it 'replaces address with an hex encoded version' do
    source = ::Rack::Response.new([hex['source']])
    munged = ::Rack::Response.new

    subject.apply(munged, source)
    expect(munged.body.first).to eq(hex['result'])
  end
end
