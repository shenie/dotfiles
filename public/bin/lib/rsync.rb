#!/usr/bin/env ruby

require 'optparse'

module Rsync
  def sync(source = nil, destination = nil)
    rsync_command = 'rsync --recursive --cvs-exclude --delete --dry-run'
    rsync_command += ' --include="*.java"'
    rsync_command += ' --include="*.sql"'
    rsync_command += ' --include="*.schema"'
    rsync_command += ' --include="*.xml"'
    rsync_command += ' --include="*.properties"'
    rsync_command += ' --exclude="*.*"'
    
    opts = OptionParser.new 
    opts.on("-r", "--real-run") { rsync_command.sub!('--dry-run', '') }
    opts.on("-c", "--checksum") { rsync_command += ' --checksum' }
    opts.on("-k", "--keey-files") { rsync_command.sub!('--delete', '') }
    rest = opts.parse($*) 
    
    rest.each {|e| rsync_command += " #{e}"}
    rsync_command += " #{source}"
    rsync_command += " #{destination}"
    
    system(rsync_command)
  end
end
