#!/usr/bin/env ruby

require 'rubygems'
gem 'mongrel'
require 'mongrel'

HOST = '0.0.0.0'
PORT = 5000

config = Mongrel::Configurator.new :host => HOST, :port => PORT do
  listener do
    uri "/", :handler => Mongrel::DirHandler.new(Dir.pwd)
  end

  trap("INT") { stop }
  run
end

puts "Mongrel running on #{HOST}:#{PORT} with docroot #{Dir.pwd}"
config.join
