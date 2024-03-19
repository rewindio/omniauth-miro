# OmniAuth Miro Strategy

OmniAuth Miro is a Ruby gem that provides authentication for your Ruby applications via the Miro OAuth 2.0 authentication system.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-miro'
```

And then execute:

```bash
bundle install
```

## Usage

1. Register your application with Miro to obtain the `MIRO_CLIENT_ID` and `MIRO_CLIENT_SECRET` credentials.

2. In your application configuration, add the following line to use the Miro OmniAuth strategy:

   ```ruby
   provider :miro, ENV['MIRO_CLIENT_ID'], ENV['MIRO_CLIENT_SECRET'], scope: 'vso.auditlog etc...', callback_path: '/link/miro/oauth_callback'
   ```

   Replace `ENV['MIRO_CLIENT_ID']` and `ENV['MIRO_CLIENT_SECRET']` with your Miro client credentials.

3. Implement the necessary routes and views to initiate the authentication process and handle the callback.

4. When users access the authentication route, they will be redirected to Miro for authentication. After successful authentication, Miro will redirect them back to your specified callback URL.

5. Access user information and tokens as needed in your application by utilizing the OmniAuth authentication data.

## Running Tests

You can run the test suite using the following command:

```bash
rake spec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the spec. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/rewindio/omniauth-miro](https://github.com/rewindio/omniauth-miro). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org) code of conduct.

## License

This gem is available as open-source software under the [MIT License](https://opensource.org/licenses/MIT).
