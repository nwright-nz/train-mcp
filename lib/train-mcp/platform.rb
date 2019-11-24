# Platform definition file.  This is a good place to separate out any
# logic regarding the identification of the OS or API at the far end
# of the connection.

module TrainPlugins::Mcp
  module Platform
    def platform
      Train::Platforms.name("mcp").in_family("cloud")
      plugin_version = "train-mcp: v#{TrainPlugins::Mcp::VERSION}"
      force_platform!("mcp", release: TrainPlugins::Mcp::VERSION)
    end
  end
end