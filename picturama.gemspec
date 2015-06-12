$:.push File.expand_path("../lib", __FILE__)
require "picturama/version"

Gem::Specification.new do |s|
  s.name        = 'picturama'
  s.version     = Picturama::VERSION
  s.summary     = "An easy picture gallery based on directory and files"
  s.description = "An easy picture gallery based on directory and files. This is mostly for general purpose and to be used in console."
  s.authors     = ["David Silveira"]
  s.email       = 'jdsilveira@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://davidsilveira.me/code/picturama-gem'
  s.licenses    = ['MIT']

  s.add_dependency('mini_magick', '~> 3.6')
  s.add_dependency('stringex', '~> 2.0')

  s.add_development_dependency 'rspec', "3.0.0"

  s.require_paths = ["lib"]

end