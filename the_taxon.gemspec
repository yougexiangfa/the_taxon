$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the_taxon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_taxon"
  s.version     = TheTaxon::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of TheTaxon."
  s.description = "TODO: Description of TheTaxon."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
end
