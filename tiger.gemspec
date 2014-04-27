# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tiger/version'

Gem::Specification.new do |spec|
  spec.name          = "tiger"
  spec.version       = Tiger::VERSION
  spec.authors       = ["hisaichi5518"]
  spec.email         = ["hisaichi5518@gmail.com"]
  spec.summary       = %q{Tiger is a mixin class to on/emit triggers (or hooks) that get called at some points you specify.}
  spec.description   = %q{Tiger is a mixin class to on/emit triggers (or hooks) that get called at some points you specify.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
