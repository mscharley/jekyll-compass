
Gem::Specification.new do |s|
  s.name        = 'jekyll-compass'
  s.version     = '1.3.0.pre'
  s.summary     = "Jekyll generator plugin to build Compass projects during site build"
  s.description = <<-EOF
    This project is a plugin for the Jekyll static website generator to allow for using Compass projects with your
    Jekyll website. Compass is an extension library for the CSS preprocessor Sass.
  EOF
  s.license     = 'MIT'
  s.authors     = ["Matthew Scharley"]
  s.email       = 'matt.scharley@gmail.com'
  s.files       = [*Dir["lib/**/*.rb"], "README.md", "LICENSE"]
  s.homepage    = 'https://github.com/mscharley/jekyll-compass'

  s.add_runtime_dependency 'compass', '~> 1.0'
  s.add_runtime_dependency 'jekyll', '~> 2.0'

end
