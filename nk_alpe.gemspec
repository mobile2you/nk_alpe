# frozen_string_literal: true

require_relative 'lib/nk_alpe/version'

Gem::Specification.new do |spec|
  spec.name          = 'nk_alpe'
  spec.version       = NkAlpe::VERSION
  spec.authors       = ['Pedro Lima']
  spec.email         = ['pedrogglima@mobile2you.com']

  spec.summary       = 'API communicate with ALPE.'
  spec.description   = 'API communicate with ALPE.'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  gem.files         = Dir['lib/**/*.rb']
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'rake', '~> 13.0.0'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubocop', '~> 1.7'
end
