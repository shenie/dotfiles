#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'

if ARGV.size != 2
  message = "Must supply username and password\n"
  message << "Usage: ruby usages.rb <username> <password>"
  abort message
end

username = ARGV[0]
password = ARGV[1]

agent = Mechanize.new

agent.get('http://tpg.com.au')
form = agent.page.forms.first
form.check_username = username
form.password = password
form.radiobuttons[0].checked = true
form.radiobuttons[1].checked = false
form.submit

if agent.page.body =~ /Invalid username, customer ID, Mobile number or password/
  abort 'Could not login, please check your username and password'
end

agent.page.link_with(:text => 'Check your Account Usage').click


agent.page.body.to_a.each { |l| 
  if l =~ /Peak Downloads used: ([0-9.]* MB)/
    puts "Peak Downloads used: #{$1}"
  end

  if l =~ /Off-Peak Downloads used: ([0-9.]* MB)/
    puts "Off-Peak Downloads used: #{$1}"
  end
}

agent.page.link_with(:text => 'Log Out').click

