# frozen_string_literal: true

module Rack
  class AddressMunging
    # This module group all available munging strategies.
    #
    # When the Rack::AddressMunging middleware is instanciated, the required
    # strategy is loaded as a child constant of this module. If you want to
    # write your own munging strategy, you must create it as a subclass of
    # <tt>Rack::AddressMunging::Strategy</tt> for it to be usable.
    module Strategy
      autoload :Hex,      'rack/address_munging/strategy/hex'
      autoload :Rot13JS,  'rack/address_munging/strategy/rot13js'
    end
  end
end
