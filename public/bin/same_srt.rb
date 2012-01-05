#!/usr/bin/env ruby

require 'fileutils'

files = Dir.glob("*.*")
raise "expected the movie & srt file only" unless files.size == 2

movie = files.find { |f| !f.include? '.srt' }

new_srt = File.basename(movie, "." + movie.split('.').last) + ".srt"

old_srt = Dir.glob('*.srt').first

puts "old srt => #{old_srt}"
puts "new srt => #{new_srt}"

FileUtils.mv old_srt, new_srt, :noop => false, :verbose => true unless new_srt == old_srt


