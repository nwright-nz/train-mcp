# Train Plugins v1 are usually declared under the TrainPlugins namespace.
# Each plugin has three components: Transport, Connection, and Platform.
# We'll only define the Transport here, but we'll refer to the others.
require "train-mcp/connection"
require "train"
require "train/plugins"

module TrainPlugins
  module Mcp
    class Transport < Train.plugin(1)
      name "mcp"

      # The only thing you MUST do in a transport is a define a
      # connection() method that returns a instance that is a
      # subclass of BaseConnection.
      option :user, required: true, default: ENV["MCP_USER"] 
      option :pass, required: true, default: ENV["MCP_PASSWORD"]
      option :org_id, required: true, default: ENV["MCP_ORG"] 
      option :url, required: true, default: ENV["MCP_ENDPOINT"]       
      puts "transport"
      # The options passed to this are undocumented and rarely used.
      def connection(_instance_opts = nil)
        puts "connection"
        # Typical practice is to cache the connection as an instance variable.
        # Do what makes sense for your platform.
        # @options here is the parsed options that the calling
        # app handed to us at process invocation. See the Connection class
        # for more details.
        @connection ||= TrainPlugins::Mcp::Connection.new(@options)
      end
    end
  end
end