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
  
else
  abort "Error: No matching action defined in #{__FILE__.inspect}"
end

# Other Ideas:
# * Open URL in browser
# * cd to a path
# * Run a spec by name
# * Run a rake task by name

