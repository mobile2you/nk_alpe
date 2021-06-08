# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/nk_alpe/version'

Gem::Specification.new do |gem|
  gem.name          = 'nk_alpe'
  gem.version       = NkAlpe::VERSION
  gem.authors       = ['Pedro Lima']
  gem.email         = ['pedrogglima@mobile2you.com']

  gem.summary       = 'API communicate with ALPE.'
  gem.description   = 'API communicate with ALPE.'
  gem.license       = 'MIT'

  gem.files         = Dir['lib/**/*.rb']
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'httparty', '~> 0.17.0'
  gem.add_dependency 'json', '~> 2.5.0'
  gem.add_dependency 'rake', '~> 13.0.0'
  gem.add_dependency 'uri', '~> 0.10.0'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubocop', '~> 1.16.0'
end
