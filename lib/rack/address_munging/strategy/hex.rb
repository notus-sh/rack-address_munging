# frozen_string_literal: true

module Rack
  class AddressMunging
    module Strategy
      class Hex
        include Detection

        def apply(munged, original)
          original.each do |part|
            part = part.dup if part.frozen?
            part.gsub!(REGEXP_EMAIL)  { |m| m = to_s(m); email?(m) ? encode(m) : m }
            part.gsub!(REGEXP_MAILTO) { |m| encode(to_s(m)) }
            munged.write part
          end
        end

        private

        def encode(str)
          to_s(str).unpack('C*').map { |c| format('&#%<c>d;', c: c) }.join
        end

        # Normalize a match as a string
        # (gsub return ActiveSupport::SafeBuffer when ActiveSupport is loaded)
        def to_s(string)
          string.respond_to?(:to_str) ? string.to_str : string.try(:to_s)
        end
      end
    end
  end
end
