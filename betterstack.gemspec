Gem::Specification.new do |spec|
  spec.name          = "betterstack"
  spec.version       = "1.0.0"
  spec.authors       = ["Umang Chouhan"]
  spec.email         = ["umang@sundaycarwash.com"]

  spec.summary       = "Ruby client for Better Stack API"
  spec.description   = "A comprehensive Ruby gem for interacting with Better Stack's uptime and telemetry APIs"
  spec.homepage      = "https://github.com/sundaycarwash/betterstack-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sundaycarwash/betterstack-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/sundaycarwash/betterstack-ruby/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "faraday-retry", "~> 2.0"
  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 6.0"
  spec.add_development_dependency "rubocop", "~> 1.0"
end
