#!/usr/bin/env rake
require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  desc "alias test task to spec"
  task test: :spec
rescue LoadError
  task(:spec) do
    warn("rspec is disabled")
  end
end
