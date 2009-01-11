#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'

module MyFinance

  def twit(msg)
    Net::HTTP.post_form(URI.parse("http://myfinance:#{ENV['MY_FINANCE_PASSWORD']}@twitter.com/statuses/update.json"), 'status' => msg)
  end

end
