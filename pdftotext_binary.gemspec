# coding: utf-8

Gem::Specification.new do |s|
  s.name = "pdftotext_binary"
  s.version = "1.0.0"
  s.license = "GPL-2.0-or-later"
  s.author = "Martin Tournoij"
  s.email = "martin@arp242.net"
  s.platform = Gem::Platform::RUBY
  s.summary = "Statically linked pdftotext binary from Poppler"
  s.files = Dir['bin/*']
  s.executables << "pdftotext"
  s.require_path = '.'
  s.homepage = 'https://github.com/olyticoIE/pdftotext_binary'
  s.required_ruby_version = '>= 3.2.0'

  s.metadata['source_code_uri'] = s.homepage

  s.add_development_dependency "minitest"
  s.add_development_dependency "rake"
end
