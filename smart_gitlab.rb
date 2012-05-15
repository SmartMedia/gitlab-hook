require 'rubygems'
require 'bundler/setup'

Bundler.require

post '/' do
  puts request.inspect
  puts params.inspect
  "Hooray!"
end
