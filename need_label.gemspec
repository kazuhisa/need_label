# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'need_label/version'

Gem::Specification.new do |s|
  s.name          = 'need_label'
  s.version       = NeedLabel::VERSION
  s.authors       = ['Yamamoto Kazuhisa']
  s.email         = ['ak.hisashi@gmail.com']
  s.description   = %q{A class is outputted about an indispensable input item.}
  s.summary       = %q{A class is outputted about an indispensable input item.}
  s.homepage      = 'https://github.com/kazuhisa/need_label'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.13'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3', '~> 1.3.0'
  s.add_development_dependency 'capybara','~> 1.1'
  s.add_development_dependency 'rr'
  s.add_dependency 'rails', '>= 3.0.7'
end

