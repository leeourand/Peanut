require File.expand_path("../lib/peanut/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "peanut"
  s.version     = Peanut::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['the_gastropod', 'chrisrhoden']
  s.email       = []
  s.homepage    = "http://rubygems.org/gems/peanut"
  s.summary     = "Peanut is a friendly remake of BOOM, where we manage simple key/value stores instead of lists."
  s.description = "Peanut is a simple command line clipboard manager similar to BOOM. We use key/value stores instead of lists, keeping things simple."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "peanut"
  
  s.add_dependency 'yajl-ruby'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
