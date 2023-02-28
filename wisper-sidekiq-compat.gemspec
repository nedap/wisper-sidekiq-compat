# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wisper/sidekiq/version'

Gem::Specification.new do |spec|
  spec.name          = "wisper-sidekiq-compat"
  spec.version       = Wisper::Sidekiq::VERSION
  spec.authors       = ["Kris Leech", "Jamie Schembri"]
  spec.email         = ["kris.leech@gmail.com", "jamie.schembri@nedap.com"]
  spec.summary       = 'Async publishing for Wisper using Sidekiq'
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/nedap/wisper-sidekiq-compat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'wisper-compat'
  spec.add_dependency 'sidekiq', '>=4.1'
end
