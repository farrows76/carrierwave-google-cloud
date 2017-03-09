$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "carrierwave/google/cloud/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "carrierwave-google-cloud"
  s.version     = Carrierwave::Google::Cloud::VERSION
  s.authors     = ["Steve Farrow"]
  s.email       = ["farrows76@gmail.com"]
  s.homepage    = "https://github.com/farrows76/carrierwave-google-cloud"
  s.summary     = "Slim Google Cloud Storage support in CarrierWave."
  s.description = "Use google for Google Cloud Storage support in CarrierWave."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency "google-cloud-storage", "~> 0.24.0"
  s.add_dependency "carrierwave", "~> 1.0"

  s.add_development_dependency "sqlite3"
end
