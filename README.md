## Inspec Train Plugin for NTT Managed Cloud Platform

This plugin allows Chef Inspec to connect to the NTT MAnaged CLoud Platform API for validation of cloud resources.   

### Usage

For local testing, just run `gem build train-mcp.gemspec` , then install the plugin using the command `inspec plugin install <path to gem file created above>`.   
You need 4 Environment variables set at present:

* MCP_USER (username for Managed Cloud Platform)
* MCP_PASSWORD (password for the above account)
* MCP_ORG (Organization ID for MCP)
* MCP_ENDPOINT (APi endpoint based on your region. See below for an example)
   
Example MCP Endpoint : https://api-au.dimensiondata.com/oec/0.9
For different regions, change the api-au in the address above to your desired region (api-na, api-eu etc).
In the future, the region will be able to be passed to Train by using mcp://<region> when you are executing controls. This is coming soon...

To validate you have a connection, run `inspec detect -t mcp://` and you should receive the following output:

```
 Platform Details ──────────────────────────────

Name:      mcp
Families:  cloud, api
Release:   0.1.2
```

