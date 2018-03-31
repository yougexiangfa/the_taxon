$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the_taxon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_taxon"
  s.version     = TheTaxon::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = "https://github.com/yigexiangfa/the_taxon"
  s.summary     = "Summary of TheTaxon."
  s.description = "Description of TheTaxon."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", 'README.md']
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 5.0'
  s.add_dependency 'closure_tree'
end
