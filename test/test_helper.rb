require 'simplecov'

#SimpleCov.root
SimpleCov.start do
  add_filter 'test'
end

SimpleCov.command_name 'Unit Tests'
