
require 'train'
require 'cloudcontrol'

# Push platform detection out to a mixin, as it tends
# to develop at a different cadence than the rest
require 'train-mcp/platform'

require 'mixlib/shellout'
require 'ostruct'

module TrainPlugins
  module Mcp
    class Connection < Train::Plugins::Transport::BaseConnection
      include TrainPlugins::Mcp::Platform
      def initialize(options)
        super(options)
        @uuid = mcp_client.account.myaccount
      end

      def mcp_client
        klass = ::CloudControl::Client
        return klass.new(@options[:url],
            @options[:org_id],
            @options[:user],
            @options[:pass])
        # @cache[:api_call][klass.to_s.to_sym] ||= klass.new(url: @options[:url], user: @options[:user], pass: @options[:pass], org_id: @options[:org_id])
      end

      def mcp_resource(klass, args)
        klass.new(args)
      end

      def unique_identifier
        @uuid = mcp_client.account.myaccount.org_id.to_json
      end
      # TODO: determine exactly what this is used for
      def uri
        "mcp://#{@options[:url]}"
      end
    end
  end
end
