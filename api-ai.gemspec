# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_ai/version'

Gem::Specification.new do |spec|
  spec.name          = 'api-ai'
  spec.version       = ApiAi::VERSION
  spec.authors       = ['Gustavo Bazan']
  spec.email         = ['contacto@gustavobazan.com']
  spec.summary       = 'api.ai Wrapper'
  spec.description   = <<-EOF
        A library that provides a plain function-call interface to the
        api.ai web endpoints.
    EOF
  spec.homepage      = 'https://github.com/gssbzn/api-ai'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
  spec.add_development_dependency 'webmock', '~> 1.21', '>= 1.21.0'
  spec.add_development_dependency 'coveralls', '~>0.8.0'
  spec.add_development_dependency 'yard', '~> 0.8.7', '>= 0.8.0'
end
