# frozen_string_literal: true

module Rack
  class AddressMunging
    module Strategy
      # The <tt>:Hex</tt> munging strategy
      #
      # Will replace email addresses and mailto href attributes values with
      # an hexadecimal HTML entities alternative.
      class Hex
        include Detection

        def apply(munged, original)
          original.each do |part|
            part = part.dup if part.frozen?
            part.gsub!(REGEXP_MAILTO) { |m| maybe_encode(m) }
            part.gsub!(REGEXP_EMAIL)  { |m| maybe_encode(m) }
            munged.write part
          end
        end

        private

        def maybe_encode(string)
          s = to_s(string)
          email?(s.gsub(/^mailto:/, '')) ? encode(s) : s
        end

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
