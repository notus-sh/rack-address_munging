# frozen_string_literal: true

describe Rack::AddressMunging do
  def builder(headers, body)
    Rack::Builder.new do
      use Rack::AddressMunging
      run(proc { [200, headers, body] })
    end
  end

  context 'when used on a non-HTML response' do
    let(:headers) { { 'Content-Type' => 'text/plain' } }
    let(:body)    { ['email@example.com'] }

    it 'should do nothing' do
      _, _, response_body = builder(headers, body).call({})
      expect(response_body).to eql(body)
    end
  end

  context 'when used on an HTML response' do
    let(:headers) { { 'Content-Type' => 'text/html' } }
    let(:body) { ['<a href="mailto:email@example.com">email@example.com</a>'] }

    it 'should do something' do
      _, _, response_body = builder(headers, body).call({})
      expect(response_body).not_to eql(body)
    end
  end
end
