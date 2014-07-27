# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ice_cube_ex/version'

Gem::Specification.new do |spec|
  spec.name          = "ice_cube_ex"
  spec.version       = IceCubeEx::VERSION
  spec.authors       = ["junhanamaki"]
  spec.email         = ["jun.hanamaki@gmail.com"]
  spec.summary       = %q{extending ice_cube with new rules}
  spec.description   = %q{extends ice_cube to handle more rules, check
                          homepage for more details}
  spec.homepage      = "https://github.com/junhanamaki/ice_cube_ex"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.3'
  spec.add_development_dependency 'jazz_hands', '~> 0.5'
  spec.add_development_dependency 'ice_cube', '~> 0.12'
end
