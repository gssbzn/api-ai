# Copyright (c) 2015 Gustavo Bazan
# MIT License

module ApiAi

  class Session # :nodoc:

    # @param [String] access_token
    # @param [String] subscription_key
    def initialize(access_token, subscription_key)
      unless access_token.is_a?(String)
        raise "bad type for access_token (expecting String)"
      end
      unless subscription_key.is_a?(String)
        raise "bad type for subscription_key (expecting String)"
      end
      @access_token = access_token
      @subscription_key = subscription_key
    end

    private

    def build_url(path) # :nodoc:
      host = ApiAi::API_SERVER
      full_path = "/v1/#{path}"
      URI::HTTPS.build({host: host, path: full_path})
    end

    def build_url_with_params(path, params) # :nodoc:
      target = build_url(path)
      target.query = ApiAi::make_query_string(params)
      target
    end

    protected

    def do_http(uri, request) # :nodoc:
      ApiAi::do_http(uri, request)
    end

    public

    def do_get(path, params=nil, headers=nil)  # :nodoc:
      params ||={}
      params["v"] = ApiAi::API_VERSION
      headers ||= {}
      headers["Authorization"] = "Bearer #{@access_token}"
      headers["ocp-apim-subscription-key"] = "Bearer #{@subscription_key}"
      uri = build_url_with_params(path, params)
      do_http(uri, Net::HTTP::Get.new(uri.request_uri))
    end

    def do_http_with_body(uri, request, body) # :nodoc:
      if body != nil
        if body.is_a?(Hash)
          request['Content-Type'] = 'application/json; charset=utf-8'
          request.body = ApiAi::clean_params(body).to_json
        elsif body.respond_to?(:read)
          if body.respond_to?(:length)
            request["Content-Length"] = body.length.to_s
          else
            raise ArgumentError, "Don't know how to handle 'body' (responds to 'read' but not to 'length' or 'stat.size')."
          end
          request.body_stream = body
        else
          s = body.to_s
          request["Content-Length"] = s.length
          request.body = s
        end
      end
      do_http(uri, request)
    end

    def do_post(path, params=nil, headers=nil)  # :nodoc:
      headers ||= {}
      headers["Authorization"] = "Bearer #{@access_token}"
      headers["ocp-apim-subscription-key"] = "Bearer #{@subscription_key}"

      uri = build_url_with_params(path, "v" => ApiAi::API_VERSION)
      do_http_with_body(uri, Net::HTTP::Post.new(uri.request_uri, headers), params)
    end

    def do_put(path, params=nil, headers=nil, body=nil)  # :nodoc:
      params ||={}
      params["v"] = ApiAi::API_VERSION
      headers ||= {}
      headers["Authorization"] = "Bearer #{@access_token}"
      headers["ocp-apim-subscription-key"] = "Bearer #{@subscription_key}"
      uri = build_url_with_params(path, params)
      do_http_with_body(uri, Net::HTTP::Put.new(uri.request_uri, headers), body)
    end
  end
end
