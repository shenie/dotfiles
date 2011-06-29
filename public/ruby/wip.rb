
watch( 'app/.*\.rb' )  { |md| 
  if md[0] =~ /(models|controllers)/
    puts '=' * 100
    spec_file = "spec/#{md[0].split('.').first}_spec.rb".gsub(/\/app\//, '/')
    if File.exists?(spec_file)
      puts "Running #{spec_file}"
      system("bundle exec rspec -t wip --format doc #{spec_file}")
    end
  end
}

watch( '.*_spec.rb' )  { |md| 
  puts '=' * 100
  puts "Running #{md[0]}"
  system("bundle exec rspec -t wip --format doc #{md[0]}")
}

watch( '.*.feature' )  { |md| 
  puts '=' * 100
  puts "Running #{md[0]}"
  system("bundle exec cucumber -r features #{md[0]}")
}
