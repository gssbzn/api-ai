module ApiAi
  module Query
    def query_get(options={})
    end

    def query_post(params={})
      raise ArgumentError.new("Required arguments 'query' missing") if params['query'].nil?
      raise ArgumentError.new("Required arguments 'sessionId' missing") if params['sessionId'].nil?
      raise ArgumentError.new("Required arguments 'lang' missing") if params['lang'].nil?
      response = @session.do_post "query", params
      ApiAi::parse_response(response)
    end

    def query_post_multipart(options={})
    end

  end
end
