# frozen_string_literal: true
#
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/workflows/version'

Gem::Specification.new do |spec|
  spec.name          = 'workflows'
  spec.version       = Workflows::VERSION
  spec.authors       = ['Alexander Auer']
  spec.email         = ['alex@afterworker.co']

  spec.summary       = 'A gem to test JIRA Workflows'
  spec.description   = 'A gem to test JIRA Workflows.'
  spec.homepage      = 'https://github.com/dompstar/jira-workflows-tests'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/dompstar/jira-workflows-tests'
  spec.metadata['changelog_uri'] = 'https://github.com/dompstar/jira-workflows-tests'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "multi_json"


end
