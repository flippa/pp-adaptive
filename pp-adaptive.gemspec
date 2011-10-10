# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adaptive_payments/version"

Gem::Specification.new do |s|
  s.name        = "pp-adaptive"
  s.version     = AdaptivePayments::VERSION
  s.authors     = ["d11wtq"]
  s.email       = ["chris@w3style.co.uk"]
  s.homepage    = "https://github.com/"
  s.summary     = %q{Rubygem for working with PayPal's Adaptive Payments API}
  s.description = %q{Currently provides just a subset of PayPal's API, for setting up preapproval agreements and taking payments}

  s.rubyforge_project = "pp-adaptive"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency     "rest-client"
  s.add_runtime_dependency     "virtus",      ">= 0.0.8"
  s.add_runtime_dependency     "json"
  s.add_development_dependency "rspec",       ">= 2.6"
end
