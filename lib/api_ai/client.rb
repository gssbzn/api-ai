# Copyright (c) 2015 Gustavo Bazan
# MIT License

require_relative 'session'
require_relative 'query'

module ApiAi
  # Use this class to make api.ai calls.
  class Client
    include Query

    # @param [String] access_token developer token
    # @param [String] subscription_key subscription token
    def initialize(access_token, subscription_key)
      if access_token.is_a?(String) && subscription_key.is_a?(String)
        @session = Session.new(access_token, subscription_key)
      else
        raise ArgumentError.new("access_token or subscription_key doesn't have a valid type")
      end
    end
  end
end
