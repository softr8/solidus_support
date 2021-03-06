# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'solidus_support/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_support'
  spec.version = SolidusSupport::VERSION
  spec.authors = ['John Hawthorn']
  spec.email = ['john@stembolt.com']

  spec.summary = 'Common runtime helpers for Solidus extensions.'
  spec.homepage = 'https://solidus.io'

  spec.files = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'solidus_core'
  spec.add_development_dependency 'solidus_extension_dev_tools'
end
