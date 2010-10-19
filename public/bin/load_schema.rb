#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "localhost",
  :username => ARGV[2],
  :password => ARGV[3] || "",
  :database => ARGV[1],
  :encoding => 'utf8'
)

load(ARGV[0])
