# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fancy_captcha/version"

Gem::Specification.new do |s|
  s.name        = "fancy_captcha"
  s.version     = FancyCaptcha::VERSION
  s.date        = Date.today
  s.authors     = ["jerryshen"]
  s.email       = ["hansay99@gmail.com"]
  s.homepage    = "https://github.com/jerryshen/fancy_captcha"
  s.summary     = "A simple captcha for Rails3."
  s.description = "A simple captcha for Rails3."

  s.rubyforge_project = "fancy_captcha"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'bundler'
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_dependency "rails", "~> 3.0"
  s.add_dependency "rmagick", "~> 2.13.1"
  s.add_dependency 'jquery-rails', "~> 1.0.16"

end

