#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'date'

if ARGV.size != 2
  message = "Must supply username and password\n"
  message << "Usage: ruby usages.rb <username> <password>"
  abort message
end

username = ARGV[0]
password = ARGV[1]

agent = Mechanize.new

agent.get('http://tpg.com.au')
form = agent.page.forms[1]
form.check_username = username
form.password = password
form.submit

if agent.page.body =~ /Invalid username, customer ID, Mobile number or password/
  abort 'Could not login, please check your username and password'
end

begin
  agent.page.links.find { |l| l.to_s == "Check Your Account Usage" }.click

  agent.page.body.split("\n").each { |l|
    if l =~ /Current Billing Period:.*Ends: ([^<]*)/
      days_left = Date.parse($1) - Date.today
      puts "Current period ends [#{$1}]: #{days_left.to_i} days to go"
    end
    if l =~ /Peak Downloads used: ([0-9.]* MB)/
      puts "Peak Downloads used: #{$1}"
    end

    if l =~ /Off-Peak Downloads used: ([0-9.]* MB)/
      puts "Off-Peak Downloads used: #{$1}"
    end
  }
rescue => e
  File.open("#{ENV['HOME']}/logs/page.html", 'w') { |f| f.puts agent.page.body }
  puts "Error: #{e}"
end

puts "Logging out..."
agent.page.link_with(:text => 'Log Out').click

