# frozen_string_literal: true

require 'rack'

module Rack
  # The Rack::AddressMunging middleware, meant to be used in your Rack stack.
  #
  # All other modules meant for use in your application are <tt>autoload</tt>ed here,
  # so it should be enough just to <tt>require 'rack/address_munging'</tt> in your code.
  #
  # To add the middleware to your stack, use:
  # <code>use Rack::AddressMunging</code>
  #
  # If you want to use another munging strategy, precise it as an argument:
  # <code>use Rack::AddressMunging, strategy: :hex</code>
  class AddressMunging
    autoload :Strategy,   'rack/address_munging/strategy'
    autoload :Detection,  'rack/address_munging/detection'

    attr_reader :strategy

    def initialize(app, options = {})
      @app = app
      @options = { strategy: :Hex }.merge(options)
      @strategy = Strategy.const_get(@options[:strategy]).new
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
