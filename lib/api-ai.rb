# Copyright (c) 2015 Gustavo Bazan
# MIT License

require 'net/https'
require 'cgi'
require 'json'

require_relative 'api_ai/version'
require_relative 'api_ai/error'
require_relative 'api_ai/session'
require_relative 'api_ai/client'

module ApiAi
  # api.ai url
  WEB_SERVER = 'api.ai'
  # api.ai api path
  API_SERVER = 'api.api.ai'

  API_VERSION = '20150520'

  # Parse response. You probably shouldn't be calling this directly.
  # This takes responses from the server and parses them.
  # It also checks for errors and raises exceptions with the appropriate messages.
  #
  # @param [Net::HTTPResponse] response
  # @param [Boolean] raw if return raw data
  # @raise [ApiAi::Error]
  # @raise [ApiAi::AuthError]
  def self.parse_response(response, raw = false)
    if response.is_a?(Net::HTTPServerError)
      fail ApiAi::Error.new("api.ai Server Error: #{response} - #{response.body}", response)
    end
    return response.body if raw
    begin
      return JSON.parse(response.body)
    rescue JSON::ParserError
      raise ApiAi::Error.new("Unable to parse JSON response: #{response.body}", response)
    end
  end
end
