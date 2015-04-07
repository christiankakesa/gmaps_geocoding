require 'simplecov'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter]

SimpleCov.start do
  add_filter '/test/'
end
