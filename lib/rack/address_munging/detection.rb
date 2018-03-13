# frozen_string_literal: true

require 'mail'
require 'ipaddr'

module Rack
  class AddressMunging
    module Detection
      REGEXP_EMAIL  = /[a-z0-9][^@\s'":<>]+@[^@\s'":<>]+[a-z0-9]/i
      REGEXP_MAILTO = /mailto:#{REGEXP_EMAIL}/i
      REGEXP_LINK   = %r{<a[^>]+?href="#{REGEXP_MAILTO}"[^>]*?>.+?</a>}i

      def email?(string)
        m = ::Mail::Address.new(string)
        return false unless m.address == string
        return false unless valid_local?(m.local)
        return false unless valid_domain?(m.domain)
        true
      rescue StandardError
        false
      end

      private

      def valid_local?(local)
        return false if local.include?('..')      # Can't contain ..
        return false if local.include?('@')       # Can't contain an @
        return false unless local !~ /^"?\s+"?$/  # Can't be blank
        true
      end

      def valid_domain?(domain)
        return false if ip_address?(domain)
        return false if local_domain?(domain)
        return false if hires_image?(domain)
        return false if domain.include?('..') # Can't contain ..
        true
      end

      def ip_address?(domain)
        ip = IpAddr.new(domain)
        ip.to_s == domain
      rescue StandardError
        false
      end

      def local_domain?(domain)
        !domain.include?('.') # Must contain at least a .
      end

      # /path/to/image@2x.format should not be matched as a valid email
      # Hashed version of the path shouldn't match either
      def hires_image?(domain)
        !(domain !~ /^\dx\.(jpe?g|gif|png|webp)$/ && domain !~ /^\dx-[0-9a-f]{32}\.(jpe?g|gif|png|webp)$/)
      end
    end
  end
end
