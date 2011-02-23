# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'bierdopje/version'

Gem::Specification.new do |s|
  s.name        = 'bierdopje'
  s.version     = Bierdopje::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jeroen Jacobs']
  s.email       = 'jeroen@openminds.be'
  s.homepage    = 'http://jeroenj.be'
  s.summary     = 'A ruby wrapper around the Bierdopje.com api'
  s.description = 'A ruby wrapper around the Bierdopje.com api'

  s.files         = Dir.glob('lib/**/*')
  s.test_files    = Dir.glob('spec/**/*')
  s.require_paths = ['lib']
  s.add_dependency('rest-client', '~> 1.6.1')
  s.add_dependency('nokogiri', '~> 1.4.4')
  s.add_development_dependency('rspec', '~> 2.5')
end
