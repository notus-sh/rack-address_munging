# frozen_string_literal: true

describe Rack::AddressMunging do
  let(:body) { ['<a href="mailto:email@example.com">email@example.com</a>'] }

  def builder(headers, body)
    Rack::Builder.new do
      use Rack::AddressMunging
      run(proc { [200, headers, body] })
    end
  end

  context 'when used on a non-HTML response' do
    it 'should do nothing' do
      _, _, response_body = builder({ 'Content-Type' => 'text/plain' }, body).call({})
      expect(response_body).to eql(body)
    end
  end

  context 'when used on an HTML response' do
    it 'should do something' do
      _, _, response_body = builder({ 'Content-Type' => 'text/html' }, body).call({})
      expect(response_body).not_to eql(body)
    end
  end
end
