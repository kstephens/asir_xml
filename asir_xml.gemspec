# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asir_xml/version'

Gem::Specification.new do |gem|
  gem.name          = "asir_xml"
  gem.version       = AsirXml::VERSION
  gem.authors       = ["Kurt Stephens"]
  gem.email         = ["ks.ruby@kurtstephens.com"]
  gem.description   = %q{XML Coder for ASIR}
  gem.summary       = %q{XML Coder for ASIR}
  gem.homepage      = "http://github.com/kstephens/abstracting_services_in_ruby"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "asir", ">= 1.1.10"

  case (RUBY_PLATFORM rescue "UNKNOWN")
  when /java/i
    gem.add_development_dependency 'spoon', '>= 0.0'
  else
    gem.add_dependency "libxml-ruby", "~> 2.3.3"
  end

  gem.add_development_dependency 'rake', '>= 0.9.0'
  gem.add_development_dependency 'rspec', '~> 2.14.0'
  gem.add_development_dependency 'simplecov', '>= 0.1'
end
