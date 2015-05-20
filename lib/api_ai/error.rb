# Copyright (c) 2015 Gustavo Bazan
# MIT License

module ApiAi
  # This is the usual error raised on any api.ai related Errors
  # @!attribute http_response
  #   @return [Object] server response
  # @!attribute error
  #   @return [String] the name of the error
  class Error < RuntimeError

    attr_accessor :http_response, :error

    def initialize(error, http_response=nil)
      @error = error
      @http_response = http_response
    end

    # String representation
    # @return [String]
    def to_s
      "#{error}"
    end
  end

  # This is the error raised on Authentication failures.  Usually this means
  # one of three things
  class AuthError < Error; end
end
