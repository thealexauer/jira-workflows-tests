require "bundler/gem_tasks"
require "rake/testtask"


RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["--color", "--format", "nested"]
end

task :default => :spec
