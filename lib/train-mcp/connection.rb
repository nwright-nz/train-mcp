# Connection definition file for an example Train plugin.

# Most of the work of a Train plugin happens in this file.
# Connections derive from Train::Plugins::Transport::BaseConnection,
# and provide a variety of services.  Later generations of the plugin
# API will likely separate out these responsibilities, but for now,
# some of the responsibilities include:
# * authentication to the target
# * platform / release /family detection
# * caching
# * filesystem access
# * remote command execution
# * API execution
# * marshalling to / from JSON
# You don't have to worry about most of this.

# This allow us to inherit from Train::Plugins::Transport::BaseConnection
require "train"
require "ddcloud"

# Push platform detection out to a mixin, as it tends
# to develop at a different cadence than the rest
require "train-mcp/platform"

# This is a support library for our file content meddling


# This is a support library for our command meddling
require "mixlib/shellout"
require "ostruct"

module TrainPlugins
  module Mcp
    # You must inherit from BaseConnection.
    class Connection < Train::Plugins::Transport::BaseConnection
      # We've placed platform detection in a separate module; pull it in here.
      include TrainPlugins::Mcp::Platform
    puts "connection"
      def initialize(options)
        # 'options' here is a hash, Symbol-keyed,
        # of what Train.target_config decided to do with the URI that it was
        # passed by `inspec -t` (or however the application gathered target information)
        # Some plugins might use this moment to capture credentials from the URI,
        # and the configure an underlying SDK accordingly.
        # You might also take a moment to manipulate the options.
        # Have a look at the Local, SSH, and AWS transports for ideas about what
        # you can do with the options.
       # Override for any cli options
        # mcp://region/my-profile
        # options[:region] = options[:host] || options[:region]
        # if options[:path]
        #   # string the leading / from path
        #   options[:profile] = options[:path].sub(%r{^/}, "")
        # end
        # Regardless, let the BaseConnection have a chance to configure itself.
        super(options)
        @uuid = mcp_client.account.myaccount.org_id
          
        # If you need to attempt a connection to a remote system, or verify your
        # credentials, now is a good time.
      end
      
      def mcp_client
        puts "client"
        klass = ::DDcloud::Client
        puts @options[:url]
        # return klass.new(url: @options[:url], org_id: @options[:org_id], user: @options[:user], pass: @options[:pass]) 
        return klass.new(@options[:url],  @options[:org_id],  @options[:user],  @options[:pass]) 

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
