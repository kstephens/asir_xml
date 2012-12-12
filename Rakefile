require "bundler/gem_tasks"

gem 'rspec'
require 'rspec/core/rake_task'

######################################################################

desc "Default => :test"
task :default => :test

desc "Run all tests"
task :test => [ :spec ]

desc "Run specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

######################################################################

desc "Install system prerequites"
task :prereq do
  case RUBY_PLATFORM
  when /darwin/i
    sh "sudo port install libxml libxslt"
  when /linux/i
    sh "sudo apt-get install libxml2-dev libxslt1-dev"
  end
end