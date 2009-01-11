#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'extensions/all'

require File.dirname(__FILE__) + '/lib/myfinance'
include MyFinance

doc = Hpricot(open("http://www.bloomberg.com/markets/index.html?Intro=intro_markets"))
mytable = doc.search("table")[9]
spans = mytable.search("tr").first.search("span")

last = spans[1].inner_html
movement = spans[2].inner_html
percentage = spans[3].inner_html

msg = "Dow Jones: last = #{last}, \nmovement = #{movement} or #{percentage}"

twit(msg)
