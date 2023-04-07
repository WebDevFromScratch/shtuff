Gem::Specification.new do |spec|
  spec.name          = 'shtuff'
  spec.version       = '0.1.0'
  spec.authors       = ['Piotr Klosinski']
  spec.email         = ['hello@piotrklosinski.me']
  spec.summary       = 'A simple task manager CLI application'
  spec.description   = 'A simple command-line interface for managing tasks'
  spec.homepage      = 'https://github.com/WebDevFromScratch/shtuff'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('{bin,lib}/**/*') + ['README.md', 'LICENSE.txt']
  spec.bindir        = 'bin'
  spec.executables   = ['shtuff']

  spec.add_dependency 'chronic', '>= 0.10.0', '< 1.0'
  spec.add_dependency 'thor', '1.2.1'
end
