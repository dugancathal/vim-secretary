require "bundler/gem_tasks"

Bundler.setup
require "rake/testtask"

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.pattern = "spec/**/*_spec.rb"
end

task :default => :spec

require 'enrar/task'
Enrar.initialize!
Enrar::Task.new