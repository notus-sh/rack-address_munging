# frozen_string_literal: true

module Rack
  class AddressMunging
    module Strategy
      # The <tt>:Rot13JS</tt> munging strategy
      #
      # Will replace email addresses and full mailto links with a <tt><script></tt> tag
      # that will print it back into the page, based on a ROT13 version.
      #
      # The ROT13 implementation used here is a bit different as the original one will not
      # replace <tt>@</tt>. This fix it, applying a second replacement to switch <tt>@</tt>
      # with <tt>(at)</tt> in the munged string.
      #
      # This strategy does not handle email addresses containing UTF-8 entities.
      class Rot13JS
        include Detection

        def apply(munged, original)
          original.each do |part|
            part = part.dup if part.frozen?
            part.gsub!(REGEXP_LINK)   { |m| maybe_encode(m) }
            part.gsub!(REGEXP_EMAIL)  { |m| maybe_encode(m) }
            munged.write part
          end
        end

        private

        def maybe_encode(string)
          s = to_s(string)
          s.scan(REGEXP_EMAIL).collect { |m| email?(to_s(m)) }.any? ? encode(s) : s
        end

        def encode(str)
          <<-ENCODED.strip
          <script type="text/javascript">document.write("#{to_s(str).tr('A-Za-z', 'N-ZA-Mn-za-m').gsub('@', '(at)')}".replace(/\(at\)/, '@').replace(/[a-z]/gi,function(c){return String.fromCharCode((c<="Z"?90:122)>=(c=c.charCodeAt(0)+13)?c:c-26);});))</script>
          ENCODED
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
