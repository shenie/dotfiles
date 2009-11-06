
watch( 'app/.*\.rb' )  { |md| 
  if md[0] =~ /(models|controllers)/
    puts '=' * 100
    spec_file = "spec/#{md[0].split('.').first}_spec.rb".gsub(/\/app\//, '/')
    puts "Running #{spec_file}"
    system("rake spec SPEC=#{spec_file}")
  end
}

watch( '.*_spec.rb' )  { |md| 
  puts '=' * 100
  puts "Running #{md[0]}"
  system("rake spec SPEC=#{md[0]}")
}
