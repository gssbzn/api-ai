# Copyright (c) 2015 Gustavo Bazan
# MIT License

require_relative 'session'
require_relative 'endpoint'

module ApiAi
  # Use this class to make api.ai calls.
  class Client
    include Endpoint

    # @param [String] access_token developer token
    # @param [String] subscription_key subscription token
    def initialize(access_token, subscription_key)
      if access_token.is_a?(String) && subscription_key.is_a?(String)
        @session = Session.new(access_token, subscription_key)
      else
        fail ArgumentError, "access_token or subscription_key doesn't have a valid type"
      end
    end
  end
end
