$:.push File.expand_path("../lib", __FILE__)
require 'rails_taxon/version'

Gem::Specification.new do |s|
  s.name = 'rails_taxon'
  s.version = RailsTaxon::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/yougexiangfa/rails_taxon'
  s.summary = "Summary of RailsTaxon."
  s.description = "Description of RailsTaxon."
  s.license = "LGPL-3.0"

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 5.0', '<= 6.0'
  s.add_dependency 'closure_tree', '>= 6.6', '<= 7.1'
end
