# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pronto/swagger/version'

Gem::Specification.new do |s|
  s.name = 'pronto-swagger'
  s.version = Pronto::Swagger::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.author = 'Andrew Morton'
  s.email = 'drewish@katherinehouse.com'
  s.homepage = 'https://github.com/drewish/pronto-swagger'
  s.summary = <<-EOF
    Pronto runner to validate Swagger/Open API files
  EOF

  s.licenses = ['MIT']
  s.required_ruby_version = '>= 2.0.0'
  s.rubygems_version = '1.8.23'

  s.files = Dir.glob('{lib}/**/*') + %w(LICENSE README.md)
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.require_paths = ['lib']

  s.add_dependency('pronto', '~> 0.9.0')
  s.add_development_dependency('rake', '~> 12.0')
  s.add_development_dependency('rspec', '~> 3.4')
end
