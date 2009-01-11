#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'extensions/all'
require 'pp'

require File.dirname(__FILE__) + '/lib/myfinance'
include MyFinance

doc = Hpricot(open("http://markets.smh.com.au/apps/mkt/indexDetails.ac?idx=XAO"))
mytable = doc.search("table")[1]
rows = mytable.search('tr')

last = rows[4].search('td').innerHTML
movement, percentage = rows[5].search('td').first.innerHTML.strip.sub('&nbsp;', '').split(' ')

msg = "All Ords: #{last}, \nmovement = #{movement} [#{percentage}]"

twit(msg)
