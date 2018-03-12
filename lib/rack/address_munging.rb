# frozen_string_literal: true

require 'rack/response'

module Rack
  class AddressMunging
    autoload :Strategy,   'rack/address_munging/strategy'
    autoload :Detection,  'rack/address_munging/detection'

    def initialize(app, options = {})
      @app = app
      @options = options.merge(strategy: :Hex)
      @strategy = Strategy::Hex.new # .const_get(@options[:strategy])
    end

    def call(env)
      @status, @headers, @response = @app.call(env)
      mung! if html?
      [@status, @headers, @response]
    end

    private

    def html?
      !(@headers['Content-Type'] =~ /html/).nil?
    end

    def mung!
      @response = Response.new([], @status, @headers).tap do |r|
        @strategy.apply(r, @response)
      end
    end
  end
end
