guard :rspec, cmd: 'bundle exec rspec' do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$})

  # watch /spec/ files
  watch(%r{^spec/(.+)_spec.rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end
end
