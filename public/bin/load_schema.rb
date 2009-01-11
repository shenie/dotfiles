#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "localhost",
  :username => ARGV[1],
  :password => ARGV[2] || "",
  :database => ARGV[0]
)

load(ARGV[0])
