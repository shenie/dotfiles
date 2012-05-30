#!/usr/bin/env ruby

require 'rubygems'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => ARGV[1],
  :password => ARGV[2] || "",
  :database => ARGV[0],
  :encoding => 'utf8'
)

ActiveRecord::SchemaDumper.dump
