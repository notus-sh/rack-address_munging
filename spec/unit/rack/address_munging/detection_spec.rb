# frozen_string_literal: true

describe Rack::AddressMunging::Detection do
  subject(:detection) do
    klass = Class.new { include Rack::AddressMunging::Detection }
    klass.new
  end

  let(:emails) { load_fixtures('detection')['emails'] }

  describe '#email?' do
    it 'returns true for a valid (non-local) email address' do
      emails['valids'].shuffle.each do |address|
        expect(detection).to be_email(address)
      end
    end

    it 'returns false for a valid but local email address' do
      emails['locals'].shuffle.each do |address|
        expect(detection).not_to be_email(address)
      end
    end

    it 'returns false for an invalid email address' do
      emails['invalids'].shuffle.each do |address|
        expect(detection).not_to be_email(address)
      end
    end

    it 'does not wrongly match hi-res image paths with email address' do
      expect(detection).not_to be_email('path/to/picture@2x.jpg')
    end
  end
end
