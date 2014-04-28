require 'simplecov'

SimpleCov.start do
  add_filter 'coverage'
  add_filter 'doc'
  add_filter 'pkg'
  add_filter 'test'
end
SimpleCov.command_name 'Unit Tests'
