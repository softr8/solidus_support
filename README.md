# SolidusSupport

This gem contains common runtime functionality for Solidus extensions.

If you are looking for development tools instead, see
[solidus_extension_dev_tools](https://github.com/solidusio-contrib/solidus_extension_dev_tools).

## Usage

### `SolidusSupport::Migration`

Rails >= 5 introduced the concept of specifying what Rails version your migration was written for,
like `ActiveRecord::Migration[5.0]`. Not specifying a version is deprecated in Rails 5.0 and removed
in Rails 5.1. This wasn't backported to Rails 4.2, so we provide this helper to return the right
parent class:

``` ruby
# On Rails 4.2
SolidusSupport::Migration[4.2] # returns `ActiveRecord::Migration`
SolidusSupport::Migration[5.0] # errors

# On Rails 5.0
SolidusSupport::Migration[4.2] # same as `ActiveRecord::Migration[4.2]`
SolidusSupport::Migration[5.0] # same as `ActiveRecord::Migration[5.0]`
```

There's no reason to use `SolidusSupport::Migration[5.0]` over `ActiveRecord::Migration[5.0]`, but
it is provided.

### Engine extensions

This extension provides a module that decorates `Rails::Engine` to seamlessly support autoloading
decorators both with the classic autoloader and with Zeitwerk on Rails 6. In order to use it, just
include the provided module in your `Engine` class:

```ruby
module SolidusExtensionName
  class Engine < Rails::Engine
    engine_name 'solidus_extension_name'

    include SolidusSupport::EngineExtensions::Decorators

    # ...
  end
end
```

If needed, also ensure to remove the original implementation of `.activate`:

```ruby
def self.activate
  Dir.glob(File.join(root, "app/**/*_decorator*.rb")) do |c|
    Rails.configuration.cache_classes ? require(c) : load(c)
  end
end

config.to_prepare(&method(:activate).to_proc)
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version, update the version number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solidusio/solidus_support.
