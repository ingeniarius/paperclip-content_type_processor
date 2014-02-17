# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperclip/content_type_processor/version'

Gem::Specification.new do |spec|
  spec.name          = "paperclip-content_type_processor"
  spec.version       = Paperclip::ContentTypeProcessor::VERSION
  spec.date          = "2014-02-17"
  spec.authors       = ["ingeniarius"]
  spec.email         = ["mail@ingeniarius.name"]
  spec.summary       = %q{Paperclip attachement processing by content type}
  spec.description   = %q{This gem is Paperclip processor which allow specify file processing based on his content type}

  spec.homepage      = "https://github.com/ingeniarius/paperclip-content_type_processor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "paperclip", ">= 3.3"
  spec.add_runtime_dependency "ruby-filemagic", "~> 0.5.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
