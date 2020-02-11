# BaseApi
A Ruby interface to the BASE API. (This library is unofficial.)
[BASE API doc](https://docs.thebase.in/docs/api/)

BASE is a Japanese service that allows you to easily open an online shop. Please check the [official page](https://thebase.in/) for details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'base_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install base_api

## Usage
### Basic usage

```ruby
# Provide authentication token
client = BaseApi::Client.new(access_token: 'bearer token')

# Fetch items
response = client.items
response['items']
```

### Default results per_page
Default results from the BASE API are 20. If you wish to change per request results number, you can set in three ways:

```bash
# Environment variable
export BASE_API_LIMIT=30
```

or

```ruby
# Arguments for initialzie a client instance
client = BaseApi::Client.new(access_token: 'bearer token', limit: 30)
```

or

```ruby
# Arguments for call api
client = BaseApi::Client.new(access_token: 'bearer token')
client.items({ limit: 30 })
```

### Pagination


### Errors


## Development
TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/base_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/base_api/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BaseApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/base_api/blob/master/CODE_OF_CONDUCT.md).
