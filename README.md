# Ofx::Data

The Open Financial Exchange standard is a standard for transferring information
between financial institutions, and between financial institutions and their
users. It specifies a messaging protocal and uses XML-based documents to
transfer data around. This gem implements an object model and serializer for
those documents, leaving the Request / Response HTTP-based parts of the
specification well alone.

At the moment it's targeting OFX 2.0.3. I'll look at later (and earlier
versions) when that's finished.

## Current state

I'm targeting statement download responses first, since that's my pressing
concern. Once that's done and I'm happy with the architecture I'll work my way
through the spec, completing the Banking section first.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ofx-data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ofx-data

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ofx-data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

