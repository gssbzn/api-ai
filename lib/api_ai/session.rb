# Copyright (c) 2015 Gustavo Bazan
# MIT License
require_relative 'request'

module ApiAi
  class Session # :nodoc:
    include Request

    # @param [String] access_token
    # @param [String] subscription_key
    def initialize(access_token, subscription_key)
      unless access_token.is_a?(String)
        fail 'bad type for access_token (expecting String)'
      end
      unless subscription_key.is_a?(String)
        fail 'bad type for subscription_key (expecting String)'
      end
      @access_token = access_token
      @subscription_key = subscription_key
    end

    def do_get(path, params = nil, headers = nil) # :nodoc:
      params ||= {}
      params['v'] = ApiAi::API_VERSION
      headers ||= {}
      headers['Authorization'] = "Bearer #{@access_token}"
      headers['ocp-apim-subscription-key'] = "Bearer #{@subscription_key}"
      uri = build_url_with_params(path, params)
      do_http(uri, Net::HTTP::Get.new(uri.request_uri))
    end

    def do_post(path, params = nil, headers = nil) # :nodoc:
      headers ||= {}
      headers['Authorization'] = "Bearer #{@access_token}"
      headers['ocp-apim-subscription-key'] = "Bearer #{@subscription_key}"

      uri = build_url_with_params(path, 'v' => ApiAi::API_VERSION)
      do_http_with_body(uri, Net::HTTP::Post.new(uri.request_uri, headers), params)
    end

    private

    def build_url(path) # :nodoc:
      host = ApiAi::API_SERVER
      full_path = "/v1/#{path}"
      URI::HTTPS.build(host: host, path: full_path)
    end

    def build_url_with_params(path, params) # :nodoc:
      target = build_url(path)
      target.query = make_query_string(params)
      target
    end
  end
end
