Gem::Specification.new do |s|
  s.name        = 'picturama'
  s.version     = Picturama::VERSION
  s.summary     = "An easy picture gallery based on directory and files"
  s.description = "An easy picture gallery based on directory and files"
  s.authors     = ["David Silveira"]
  s.email       = 'jdsilveira@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://davidsilveira.me/picturama'

  s.add_dependency('mini_magick', '~> 3.6.0')

  s.add_development_dependency 'rspec'

  s.require_paths = ["lib"]

end