require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'yard'

require_relative 'lib/gmaps_geocoding/version'

task gem: :build
task :build do
  system 'gem build gmaps_geocoding.gemspec'
end

task install: :build do
  system "gem install gmaps_geocoding-#{GmapsGeocoding::VERSION}.gem"
end

task release: :build do
  system "git tag -a v#{GmapsGeocoding::VERSION} -m 'Tagging #{GmapsGeocoding::VERSION}'"
  system 'git push --tags'
  system "gem push gmaps_geocoding-#{GmapsGeocoding::VERSION}.gem"
  system "rm gmaps_geocoding-#{GmapsGeocoding::VERSION}.gem"
end

Rake::TestTask.new do |t|
  t.libs << 'lib/gmaps_geocoding'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end
task default: [:test, :rubocop]

RuboCop::RakeTask.new do |task|
  task.formatters = ['simple']
  task.fail_on_error = false
end

desc 'Generate documentation'
YARD::Rake::YardocTask.new do |t|
  t.files = %w(lib/**/*.rb - LICENSE.txt)
  t.options = %w(--main README.md --no-private)
end
