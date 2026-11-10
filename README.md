# Devengo API Ruby client

[![ci](https://github.com/devengoapp/devengo-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/devengoapp/devengo-ruby/actions/workflows/ci.yml)

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

To install this gem onto your local machine, run `bundle exec rake install`.

### Releasing

Anyone with write access can release:

1. Open a PR titled `Bump to vX.Y.Z` that:
   - bumps the version in `lib/devengo/version.rb` and in `Gemfile.lock` (`bundle install`);
   - moves the entries under `## [Unreleased]` in `CHANGELOG.md` into a new `## [X.Y.Z] - YYYY-MM-DD` section, following [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

   Merge it once CI passes.
2. Tag the merge commit on `main` and push the tag:

   ```sh
   git switch main && git pull
   git tag -m vX.Y.Z vX.Y.Z
   git push origin vX.Y.Z
   ```

The tag triggers `release.yml`, which runs CI, fails unless the tag is on `main` and `CHANGELOG.md` has a section for the version, and publishes the gem to [rubygems.org](https://rubygems.org/gems/devengo-api) through [trusted publishing](https://guides.rubygems.org/trusted-publishing/) with a [Sigstore](https://www.sigstore.dev) attestation. No API key is involved.

If the `publish` job fails, fix the cause and re-run the failed job; the tag stays as it is.

Once published, create a [GitHub release](https://github.com/devengoapp/devengo-ruby/releases) for the tag with the version's changelog section as notes.

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
