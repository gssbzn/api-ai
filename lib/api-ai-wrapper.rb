require 'net/https'
require 'cgi'
require 'json'

require_relative "api_ai/version"
require_relative "api_ai/error"
require_relative "api_ai/session"
require_relative "api_ai/client"

module ApiAi
  # api.ai url
  WEB_SERVER = 'api.ai'
  # api.ai api path
  API_SERVER = 'api.api.ai/v1'

  API_VERSION = '20150520'

  # Removes nil params
  #
  # @param [Hash] params
  #   API call arguments
  # @return [Hash]
  def self.clean_params(params)
    r = {}
    params.each do |k,v|
      r[k] = v.to_s unless v.nil?
    end
    r
  end

  # Convert params to query string
  #
  # @param [Hash] params
  #   API call arguments
  # @return [String]
  def self.make_query_string(params)
    clean_params(params).collect {|k,v|
      CGI.escape(k) + "=" + CGI.escape(v)
    }.join("&")
  end

  # Handle http requests
  # @param [URI::HTTPS] uri
  #   API uri
  # @param [Object] request
  #   request object
  # @return [Net::HTTPResponse]
  def self.do_http(uri, request)

    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true

    # Let then know about us
    request['User-Agent'] =  "RubyAPIWrapper"

    begin
      http.request(request)
    rescue OpenSSL::SSL::SSLError => e
      raise ApiAi::Error.new("SSL error connecting to Slack.")
    end
  end

  # Parse response. You probably shouldn't be calling this directly.  This takes responses from the server
  # and parses them.  It also checks for errors and raises exceptions with the appropriate messages.
  # @param [Net::HTTPResponse] response
  # @param [Boolean] raw if return raw data
  # @raise [ApiAi::Error]
  # @raise [ApiAi::AuthError]
  def self.parse_response(response, raw=false)
    if response.kind_of?(Net::HTTPServerError)
      raise ApiAi::Error.new("api.ai Server Error: #{response} - #{response.body}", response)
    elsif response.kind_of?(Net::HTTPUnauthorized)
      raise ApiAi::AuthError.new("Not authenticated.", response)
    elsif !response.kind_of?(Net::HTTPSuccess)
      begin
        d = JSON.parse(response.body)
      rescue
        raise ApiAi::Error.new("api.ai Error: body=#{response.body}", response)
      end
      if d['error']
        raise ApiAi::Error.new(d['error'], response)
      else
        raise ApiAi::Error.new(response.body, response)
      end
    end

    return response.body if raw

    begin
      return JSON.parse(response.body)
    rescue JSON::ParserError
      raise ApiAi::Error.new("Unable to parse JSON response: #{response.body}", response)
    end
  end

  # A string comparison function that is resistant to timing attacks.  If you're comparing a
  # string you got from the outside world with a string that is supposed to be a secret, use
  # this function to check equality.
  # @param [String] a
  # @param [String] b
  # @return [Boolean] whether the strings are equal
  def self.safe_string_equals(a, b)
    if a.length != b.length
      false
    else
      a.chars.zip(b.chars).map {|ac,bc| ac == bc}.all?
    end
  end
end
