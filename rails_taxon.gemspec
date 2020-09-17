$:.push File.expand_path('lib', __dir__)
require 'rails_taxon/version'

Gem::Specification.new do |s|
  s.name = 'rails_taxon'
  s.version = RailsTaxon::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_taxon'
  s.summary = 'Taxon helpers with closure true'
  s.description = 'Taxon helpers with closure true'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_dependency 'closure_tree', '>= 7.2'
  s.add_dependency 'acts_as_list', '>= 1.0'
end
