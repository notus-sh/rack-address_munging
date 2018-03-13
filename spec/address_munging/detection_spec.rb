# frozen_string_literal: true

describe Rack::AddressMunging::Detection do
  let(:emails) { load_data('detection')['emails'] }
  subject do
    klass = Class.new { include Rack::AddressMunging::Detection }
    klass.new
  end

  describe '#email?' do
    it 'returns true for a valid (non-local) email address' do
      emails['valids'].shuffle.each do |address|
        expect(subject.email?(address)).to be_truthy
      end
    end

    it 'returns false for a valid but local email address' do
      emails['locals'].shuffle.each do |address|
        expect(subject.email?(address)).to be_falsey
      end
    end

    it 'returns false for an invalid email address' do
      emails['invalids'].shuffle.each do |address|
        expect(subject.email?(address)).to be_falsey
      end
    end

    it 'does not wrongly match hi-res image paths with email address' do
      expect(subject.email?('path/to/picture@2x.jpg')).to be_falsey
    end
  end
end
