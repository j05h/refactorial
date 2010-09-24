# -*- encoding: utf-8 -*-
require File.expand_path("../lib/refactorial/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = %q{refactorial}
  s.version     = Refactorial::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = %w{ j05h cajun }
  s.email       = %w{josh@kleinpeter.org zac@kleinpeter.org}
  s.homepage    = %q{http://github.com/j05h/refactorial}
  s.summary     = %q{Helps you with code reviews}
  s.description = %q{A companion gem to refactorial.com.  See refactorial.com for details}
  s.date        = %q{2010-09-04}

  s.required_rubygems_version = '~> 1.3.6'

  s.add_development_dependency 'bundler',       '~> 1.0.0'
  s.add_development_dependency 'shoulda',       '~> 2.11'
  s.add_development_dependency 'yard',          '~> 0.6'
  s.add_development_dependency 'vcr',           '~> 1.1.2'
  s.add_development_dependency 'fakeweb',       '~> 1.3.0'
  s.add_development_dependency 'rr',            '~> 1.0.0'

  s.add_dependency 'yajl-ruby',   '~> 0.7.7'
  s.add_dependency 'rest-client', '~> 1.6.1'
  s.add_dependency 'gist',        '~> 1.2.1'

  s.extra_rdoc_files   = [ "README.rdoc" ]
  s.test_files         = `git ls-files test`.split("\n")

  s.files              = `git ls-files`.split("\n")
  s.executables        = ['refactorial']
  s.require_paths      = ["lib"]
end
