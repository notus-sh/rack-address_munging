# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/address_munging/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-address_munging'
  spec.version       = Rack::AddressMunging::VERSION
  spec.licenses      = ['Apache-2.0']
  spec.authors       = ['Gaël-Ian Havard']
  spec.email         = ['gael-ian@notus.sh']

  spec.summary       = 'Rack middleware for automatic address munging.'
  spec.description   = 'A Rack middleware for automatic e-mail addresses munging.'
  spec.homepage      = 'https://github.com/notus-sh/rack-address_munging'

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required."
  end

  spec.require_paths = ['lib']
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency 'mail', '> 2.5.0'
  spec.add_dependency 'rack', '>= 0.9.1'

  spec.add_development_dependency 'bundler',  '~> 1.16'
  spec.add_development_dependency 'rake',     '~> 10.0'
  spec.add_development_dependency 'rspec',    '~> 3.7.0'
  spec.add_development_dependency 'rubocop'
end
