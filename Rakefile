require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

desc 'Access the refactorial code in the console'
task :console do
  sh "irb -r rubygems -r #{File.dirname( __FILE__ ) + '/lib/refactorial.rb'}"
end
