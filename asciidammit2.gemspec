# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asciidammit/version'

Gem::Specification.new do |spec|
  spec.name          = 'asciidammit2'
  spec.version       = Asciidammit::VERSION
  spec.authors       = ['Forrest Chang']
  spec.email         = ['fkc_email-ruby@yahoo.com']
  spec.summary       = %q{ A straight port of asciidammit.py.}
  spec.description   = %q{ A straight port of asciidammit.py used for a work project, made into a gem to be used elsewhere. There is an asciidammit gem which sports a different interface.}
  spec.homepage      = 'https://github.com/fkchang/asciidammit2'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '>= 3.11.0'
  spec.add_development_dependency 'rspec-nc'
end
