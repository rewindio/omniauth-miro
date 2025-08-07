# frozen_string_literal: true

require File.expand_path('lib/omni_auth/miro/version', __dir__)

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-miro'
  gem.version       = OmniAuth::Miro::VERSION
  gem.authors       = ['Rewind Software Inc. | Calvin Chen']
  gem.email         = ['team@rewind.io']

  gem.summary       = 'A Miro OAuth strategy for OmniAuth 2.0'
  gem.description   = 'A Miro OAuth strategy for OmniAuth 2.0'
  gem.homepage      = 'https://github.com/rewindio/omniauth-miro'
  gem.license       = 'MIT'
  gem.metadata = {
    'rubygems_mfa_required' => 'false',
    'bug_tracker_uri' => "#{gem.homepage}/issues",
    'changelog_uri' => "#{gem.homepage}/blob/main/CHANGELOG.md",
    'documentation_uri' => gem.homepage.to_s,
    'homepage_uri' => gem.homepage.to_s,
    'source_code_uri' => gem.homepage.to_s
  }

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|.github|examples)/}) }
  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 3.4'

  gem.add_dependency 'omniauth', '>= 1', '< 3'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
end
