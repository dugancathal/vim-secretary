# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vim/secretary/version'

Gem::Specification.new do |spec|
  spec.name          = "vim-secretary"
  spec.version       = Vim::Secretary::VERSION
  spec.authors       = ["TJ Taylor"]
  spec.email         = ["ttaylor@tendrilinc.com"]
  spec.description   = %q{Time management through vim with Ruby}
  spec.summary       = %q{I use exactly two tools on a regular basis, vim and ruby. It only seems right that, in order to track where I am, I use those tools}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Environment Related
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'thin'

  # Test Related
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rack-test'

  spec.add_dependency 'activerecord', '>= 3.2'
  spec.add_dependency 'activesupport', '>= 3.2'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'haml'
  spec.add_dependency 'redcarpet'
  spec.add_dependency 'treetop'
end
