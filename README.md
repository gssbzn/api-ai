# ApiAi
[![Gem Version](https://badge.fury.io/rb/api-ai.svg)](http://badge.fury.io/rb/api-ai)
[![Build Status](https://travis-ci.org/gssbzn/api-ai.svg)](https://travis-ci.org/gssbzn/api-ai)
[![Code Climate](https://codeclimate.com/github/gssbzn/api-ai/badges/gpa.svg)](https://codeclimate.com/github/gssbzn/api-ai)
[![Coverage Status](https://coveralls.io/repos/gssbzn/api-ai/badge.svg?branch=master&service=github)](https://coveralls.io/github/gssbzn/api-ai)

A library that provides a plain function-call interface to the Slack API web endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api-ai'
```

And then execute:

```console
bundle
```

Or install it yourself as:

```console
gem install api-ai
```

## Usage

```ruby
client = ApiAi::Client.new AI_ACCESS_TOKEN, AI_SUBSCRIPTION_TOKEN
response = client.query 'query' => "test", 'lang' => 'en', 'sessionId' => current_user.id, 'timezone' => current_user.timezone
# { "id"=>"...",
#   "timestamp"=>"...",
#   "result"=>{
#     "source"=>"domains",
#     "resolvedQuery"=>"test",
#     "action"=>"smalltalk.user",
#     "parameters"=>{"simplified"=>"i am testing you"},
#     "metadata"=>{},
#     "fulfillment"=>{"speech"=>"I encourage you to test me often. That helps my developers improve my performance."}
#   },
#  "status"=>{"code"=>200, "errorType"=>"success"}}
```

## Additional Resources

api.ai docs: https://docs.api.ai/docs/welcome

## Contributing

1. Fork it ( https://github.com/[my-github-username]/api-ai/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT License. Copyright 2015 Gustavo Bazan. http://gustavobazan.com
