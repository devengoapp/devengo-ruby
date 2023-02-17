# Devengo API Ruby client

[//]: # ([![ci]&#40;https://github.com/Nachooc5/devengo-ruby/actions/workflows/ci.yml/badge.svg?branch=main&#41;]&#40;https://github.com/Nachooc5/devengo-ruby/actions/workflows/ci.yml&#41;)

[//]: # ([![Gem Version]&#40;https://badge.fury.io/rb/git.svg&#41;]&#40;https://badge.fury.io/rb/git&#41;)

[//]: # ([![Depfu]&#40;https://badges.depfu.com/badges/53d67659d6a6d681e7513c94fd84e5ed/count.svg&#41;]&#40;https://depfu.com/repos/github/Nachooc5/devengo-ruby?project_id=37874&#41;)

Ruby client for Devengo (cf. <https://docs.devengo.com/>)

Run `bin/console` for an interactive prompt to experiment with the code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "devengo-api"
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install devengo-api
```

## Release

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then tag and push the new version:

```git
git tag vx.x.x main
git push origin vx.x.x
```

The tagging will trigger the GitHub action defined in `release.yml`, pushing the gem to [rubygems.org](https://rubygems.org).

## Testing

Any change should be tested. Builds with failures would not be allowed to merge.
To run your test suite locally using Rspec:

```ruby
bundle exec rspec
```

To prepare your environment to listen for your local code changes use Guard instead:

```ruby
bundle exec guard
```

To test services, we have a spec system that uses the [Webmock](https://github.com/bblimke/webmock) library to stub requests and checks them against service response HTTP format files.
These HTTP files are stored in the `spec/fixtures/responses` directory.

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/devengoapp/devengo-ruby>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/devengoapp/devengo-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Devengo project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/devengoapp/devengo-ruby/blob/main/CODE_OF_CONDUCT.md).
