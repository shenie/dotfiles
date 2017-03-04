#!/usr/bin/env ruby

require 'fileutils'
require "pp"
require "yaml"
require "erb"

include FileUtils

# Configurations
HOME = ENV['HOME']
INSTALL_DIR = File.expand_path(File.dirname(__FILE__))
PRIVATE_DIR = "#{INSTALL_DIR}/private"
PUBLIC_DIR = "#{INSTALL_DIR}/public"
BIN_DIR = "#{HOME}/bin"
HOST = `hostname`.split('.').first.strip

raise "#{PRIVATE_DIR} does not exists" unless File.exist? PRIVATE_DIR

CONFIG = YAML::load(ERB.new(File.readlines("#{PRIVATE_DIR}/config.yml").join).result)
SETTINGS = CONFIG[HOST] || {}

def install_link(src, file)
  link = file =~ /^\// ? file : "#{HOME}/#{file}"

  if File.exist?(link) && !File.symlink?(link) && !File.identical?(link, src)
    printf "        #{link} is not a symlink and different to #{src}\n"
  else
    remove_file(link) if File.exist?(link) || File.symlink?(link)
    ln_s(src, link)
    printf "    Installed #{link} -> #{src}\n"
  end
end

# Install copied files
mkdir BIN_DIR unless File.exist? BIN_DIR

# Install symlinked files
[SETTINGS, CONFIG].collect {|h| h['mappings'] }.inject({}) { |r, h| r.merge!(h) if h; r }.each do |file, src|
  install_link(src, file)
end
