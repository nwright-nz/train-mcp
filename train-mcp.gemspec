# As plugins are usually packaged and distributed as a RubyGem,
# we have to provide a .gemspec file, which controls the gembuild
# and publish process.  This is a fairly generic gemspec.

# It is traditional in a gemspec to dynamically load the current version
# from a file in the source tree.  The next three lines make that happen.
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "train-mcp/version"

Gem::Specification.new do |spec|
  # Importantly, all Train plugins must be prefixed with `train-`
  spec.name          = "train-mcp"

  # It is polite to namespace your plugin under TrainPlugins::YourPluginInCamelCase
  spec.version       = TrainPlugins::Mcp::VERSION
  spec.authors       = ["Nigel Wright"]
  spec.email         = ["nigel.wright@global.ntt"]
  spec.summary       = "Train Plugin for the NTT Managed Cloud Platform (cloud control)"
  spec.description   = "Example for implementing a Train plugin.  This simply performs the ROT13 substitution cipher on file content and command output."
  spec.homepage      = "https://github.com/inspec/train/tree/master/examples/plugin"
  spec.license       = "Apache-2.0"

  # Though complicated-looking, this is pretty standard for a gemspec.
  # It just filters what will actually be packaged in the gem (leaving
  # out tests, etc)
  spec.files = %w{
    README.md train-mcp.gemspec Gemfile
  } + Dir.glob(
    "lib/**/*", File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
  spec.require_paths = ["lib"]

  # If you rely on any other gems, list them here with any constraints.
  # This is how `inspec plugin install` is able to manage your dependencies.
  # For example, perhaps you are writing a thing that talks to AWS, and you
  # want to ensure you have `aws-sdk` in a certain version.

  # If you only need certain gems during development or testing, list
  # them in Gemfile, not here.
  # Do not list inspec as a dependency of the train plugin.

  # All plugins should mention train, > 1.4
  # spec.add_dependency "train", "~> 3.0"
  spec.add_dependency 'didata_cloud_sdk', '0.3.3'

end
