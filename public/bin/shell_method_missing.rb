#!/usr/bin/env ruby

# DESCRIPTION: Tries to do something with unrecognized shell input.
#              See the case statement for descriptions and examples.
#
# AUTHOR:      Bodaniel Jeanes
#              http://github.com/bjeanes/dot-files
#
# MODIFIED:    Geoffrey Grosenbach
#              http://peepcode.com
#
# INSTALL:
#              zsh:
#                   function command_not_found_handler() {
#                     ~/bin/shell_method_missing $*
#                   }

# Use all arguments
command = ARGV

# Prints and runs a command.
#
# @param [String, Array] cmd Command to run.
#   Automatically joins Arrays with &&.

def run(*cmd)
  $stderr.puts "Running '#{cmd.join(' ')}' instead"
  system(*cmd)
end

def echo(message)
  $stderr.puts("\n" + message)
end

case command.join(' ')

when /^[A-Za-z0-9_\-\/]+\.gem$/
  # Install a gem
  # @example
  #   haml.gem
  gem_to_install = command.first.gsub(/\.gem$/, '')
  run "gem", "install", gem_to_install
  
when /^[A-Za-z0-9_\-\/]+\.mate$/
  # Open the gem in textmate
  # @example
  #   haml.mate
  gem_to_open = command.first.gsub(/\.mate$/, '')
  run "gem which #{gem_to_open} | tail -1 | xargs dirname | sed -e's/$/\\/../' | xargs mate"

when /^[A-Za-z0-9_\-\/]+\.cukes$/
  # Run cucumber with tag
  # @example
  #   wip.cukes
  tag = command.first.gsub(/\.cukes$/, '')
  run "cucumber -r features/ -t @#{tag} features/"

when /^[A-Za-z0-9_\-\/]+\.tmproj$/
  # Open project with textmate
  # @example
  #   tbb.tmproj
  project = command.first.gsub(/\.tmproj/, '')
  tmproj = `find ~/dev -name #{project}.tmproj -maxdepth 3`
  if tmproj.strip.length != 0
    run "open #{tmproj}".strip
  else
    run "find ~/dev -name #{project} -type d -maxdepth 3 | xargs mate"
  end

when /=/
  # skip things such as 'PATH=$PATH:~/bin' etc
when /\$\{TM/
  # skip TextMate Markdown preview command
when /^~/
  # skip things such as '~/bin/tpg.rb' etc
else
  abort "Error: No matching action (#{command.join(' ')}) defined in #{__FILE__.inspect}" 
end

# Other Ideas:
# * Open URL in browser
# * cd to a path
# * Run a spec by name
# * Run a rake task by name

