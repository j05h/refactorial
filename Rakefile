# -*- ruby -*-

require 'rubygems'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "refactorial"
    gem.summary = %Q{Helps you with code reviews}
    gem.description = %Q{A companion gem to refactorial.com.  See refactorial.com for details}
    gem.email = "josh@kleinpeter.org"
    gem.homepage = "http://github.com/j05h/refactorial"
    gem.authors = ["j05h"]
    gem.add_development_dependency "shoulda", ">= 2.11"
    gem.add_dependency "gist"
    gem.add_dependency "xmpp4r-simple"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "refactorial #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


# vim: syntax=ruby
