# coding: utf-8
require 'English'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gmaps_geocoding/version'

Gem::Specification.new do |s|
  s.name = 'gmaps_geocoding'
  s.version = GmapsGeocoding::VERSION
  s.authors = ['Christian Kakesa']
  s.email = ['christian.kakesa@gmail.com']
  s.description = <<-END
    A simple Ruby gem for Google Maps Geocoding API.
    This gem return a Ruby Hash object of the result.
  END
  s.summary = 'Use Google Geocoding API from Ruby.'
  s.homepage = 'https://github.com/fenicks/gmaps_geocoding'
  s.license = 'MIT'

  s.files = `git ls-files`.split($RS)
  s.executables = s.files.grep(%r{^bin\/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)\/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.0'
  s.add_runtime_dependency 'oj', '~> 2.18', '>= 2.18.0'
  s.add_runtime_dependency 'oj_mimic_json', '~> 1.0', '>= 1.0.1'
  s.add_runtime_dependency 'ox', '~> 2.4', '>= 2.4.7'
  s.add_runtime_dependency 'json', '~> 2.0', '>= 2.0.2'
  s.add_runtime_dependency 'rainbow', '~> 2.1.0'
  s.add_development_dependency 'bundler', '~> 1.13', '>= 1.13.7'
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'yard', '~> 0'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'test-unit', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 0'
  s.add_development_dependency 'coveralls', '~> 0'
end
