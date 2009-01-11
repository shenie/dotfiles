#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'hpricot'

doc = Hpricot(open("http://www.shell.com.au/petrolpricing_scuba/sydney.asp"))
price = doc.search('td.smallprice').first.inner_html
entry = "#{Time.now.strftime('%Y/%m/%d')}, #{Time.now.strftime('%a')}, Shell, #{price}\n"

csv = File.dirname(__FILE__) + '/petrol.csv'

File.open csv, 'a' do |f|
  f.write entry
end

