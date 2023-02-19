# frozen_string_literal: true

def builder(headers, body)
  Rack::Builder.new do
    use Rack::AddressMunging
    run(proc { [200, headers, body] })
  end
end

describe Rack::AddressMunging do
  let(:body) { ['<a href="mailto:email@example.com">email@example.com</a>'] }

  context 'when used on a non-HTML response' do
    it 'does nothing' do
      _, _, response_body = builder({ 'Content-Type' => 'text/plain' }, body).call({})
      expect(response_body).to eql(body)
    end
  end

  context 'when used on an HTML response' do
    it 'does something' do
      _, _, response_body = builder({ 'Content-Type' => 'text/html' }, body).call({})
      expect(response_body).not_to eql(body)
    end
  end

  context 'when instatiated' do
    it 'loads the asked strategy if given' do
      middleware = described_class.new(proc { [200, headers, body] }, strategy: :Rot13JS)
      expect(middleware.strategy.class.name).to eql('Rack::AddressMunging::Strategy::Rot13JS')
    end

    it 'loads the default strategy if none given' do
      middleware = described_class.new(proc { [200, headers, body] })
      expect(middleware.strategy.class.name).to eql('Rack::AddressMunging::Strategy::Hex')
    end
  end
end
