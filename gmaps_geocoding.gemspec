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

  s.add_runtime_dependency 'rest-client', '~> 1.8'
  s.add_runtime_dependency 'yajl-ruby', '~> 1.2'
  s.add_runtime_dependency 'nori', '~> 2.5'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
  s.add_development_dependency 'bundler', '~> 1.7', '>= 1.7.0'
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'yard', '~> 0'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'test-unit', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 0'
end
