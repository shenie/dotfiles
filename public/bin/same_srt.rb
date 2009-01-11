#!/usr/bin/env ruby

require 'fileutils'

avi_file_name = File.basename(Dir.glob('*.avi').first, '.avi')

FileUtils.mv Dir.glob('*.srt').first, "#{avi_file_name}.srt", :noop => false, :verbose => true


