# frozen_string_literal: true

module Rack
  class AddressMunging
    module Strategy
      autoload :Hex, 'rack/address_munging/strategy/hex'
    end
  end
end
