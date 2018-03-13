# frozen_string_literal: true

module Rack
  class AddressMunging
    module Strategy
      autoload :Hex,      'rack/address_munging/strategy/hex'
      autoload :Rot13JS,  'rack/address_munging/strategy/rot13js'
    end
  end
end
