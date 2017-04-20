# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marketplace/version'

Gem::Specification.new do |spec|
  spec.name          = "marketplace"
  spec.version       = Marketplace::VERSION
  spec.authors       = ["William Barela"]
  spec.email         = ["william.barela.dev@gmail.com"]

  spec.summary       = %q{Rubygem which allows users to read the top stories in APM Marketplace.}
  spec.description   = %q{Marketplace is a gem which shows the top stories of APM Marketplace and allows users to read the headlines, select a story to read the story, and to open a Chrome app.}
  spec.homepage      = "https://williambarela.github.io/marketplace-cli-app/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", "~> 1.7.1"
  spec.add_development_dependency "net_http_ssl_fix"
  spec.add_development_dependency "colorize", "~> 0.8.1"
end
