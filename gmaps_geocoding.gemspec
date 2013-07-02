# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gmaps_geocoding/version'

Gem::Specification.new do |s|
  s.name          = 'gmaps_geocoding'
  s.version       = GmapsGeocoding::VERSION
  s.authors       = ['Christian Kakesa']
  s.email         = ['christian.kakesa@gmail.com']
  s.description   = %q{
    A simple Ruby gem for Google Maps Geocoding API.
    This gem return a Ruby Hash object of the result.
  }
  s.summary       = %q{Use Google Geocoding API from Ruby.}
  s.homepage      = 'https://github.com/fenicks/gmaps_geocoding'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rest-client', '~> 1.6.7'
  s.add_runtime_dependency 'yajl-ruby', '~> 1.1.0'
  s.add_runtime_dependency 'nori', '~> 2.2.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6.0'
  s.add_development_dependency 'bundler', '~> 1.3.5'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
end
