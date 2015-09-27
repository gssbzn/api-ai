# Copyright (c) 2015 Gustavo Bazan
# MIT License

module ApiAi
  module Endpoint
    module Query
      # Checks API calling code.
      #
      # @param [Hash] params
      #   API call arguments
      # @option params [String] 'query'
      #   The natural language text to be processed. The request can have multiple query parameters.
      # @option params [String] 'sessionId'
      #   A string token up to 36 symbols long, used to identify the client and to manage sessions parameters (including contexts) per client.
      # @option params [String] 'lang'
      #   Language tag, e.g. EN, ES
      #
      # @see http://api.ai/docs/reference/#query
      def query(params = {})
        fail ArgumentError, "Required arguments 'query' missing" if params['query'].nil?
        fail ArgumentError, "Required arguments 'sessionId' missing" if params['sessionId'].nil?
        fail ArgumentError, "Required arguments 'lang' missing" if params['lang'].nil?
        response = @session.do_post 'query', params
        ApiAi.parse_response(response)
      end
    end
  end
end
