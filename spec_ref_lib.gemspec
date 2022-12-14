# frozen_string_literal: true

require_relative './lib/config'

Gem::Specification.new do |s|
  s.name        = 'spec_ref_lib'
  s.version     = SpecRefLib::Config.version
  s.summary     = ''
  s.description = 'A rspec library'
  s.authors     = ['Kyle Swaffield']
  s.email       = 'kyle@swaff.iu.au'
  s.files       = [
    'lib/spec_ref_lib.rb',
    'lib/handle_file.rb',
    'lib/helpers.rb',
    'lib/method.rb',
    'lib/menu.rb',
    'lib/config.rb',
  ]
  s.homepage    = 'https://rubygems.org/gems/spec_ref_lib'
  s.license     = 'MIT'
  s.executables << 'spec-ref-lib'
  s.required_ruby_version = '>= 2.6'
end
