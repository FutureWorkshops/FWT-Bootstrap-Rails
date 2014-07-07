# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fwt_bootstrap_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "fwt_bootstrap_rails"
  spec.version       = FwtBootstrapRails::VERSION
  spec.authors       = ["Matt Brooke-Smith"]
  spec.email         = ["matt@futureworkshops.com"]
  spec.description   = "Helpers for using Bootstrap 3 with Rails"
  spec.summary       = "Helpers for using Bootstrap 3 with Rails"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib", "app"]

  spec.add_dependency 'sass-rails', '>= 3.2'
  spec.add_dependency 'bootstrap-sass', '>= 3.0.3.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec-html-matchers'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  
end
