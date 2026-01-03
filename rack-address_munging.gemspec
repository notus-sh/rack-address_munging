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

  raise 'RubyGems 2.0 or newer is required.' unless spec.respond_to?(:metadata)

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'rubygems_mfa_required' => 'true',

    'bug_tracker_uri' => 'https://github.com/notus-sh/rack-address_munging/issues',
    'changelog_uri' => 'https://github.com/notus-sh/rack-address_munging/blob/main/CHANGELOG.md',
    'homepage_uri' => 'https://github.com/notus-sh/rack-address_munging',
    'source_code_uri' => 'https://github.com/notus-sh/rack-address_munging',
    'funding_uri' => 'https://opencollective.com/notus-sh'
  }

  spec.require_paths = ['lib']

  excluded_dirs = %r{^(.github|spec)/}
  excluded_files = %w[.gitignore .rspec .rubocop.yml Gemfile Gemfile.lock Rakefile]
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(excluded_dirs) || excluded_files.include?(f)
  end

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'mail', '> 2.5.0'
  spec.add_dependency 'net-smtp'
  spec.add_dependency 'rack', '>= 2.1.4'

  spec.add_development_dependency 'bundler',  '>= 2.1'
  spec.add_development_dependency 'rake',     '~> 13.0'
  spec.add_development_dependency 'rspec',    '~> 3.13.0'
end
