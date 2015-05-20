# Copyright (c) 2015 Gustavo Bazan
# MIT License

require_relative 'endpoint/query'
require_relative 'endpoint/tts'
require_relative 'endpoint/entities'
require_relative 'endpoint/intents'
require_relative 'error'

module ApiAi
  module Endpoint
    include Query
    include Tts
    include Entities
    include Intents
  end
end
