# Rack::AddressMunging

[![Build Status](https://travis-ci.org/notus-sh/rack-address_munging.svg?branch=master)](https://travis-ci.org/notus-sh/rack-address_munging)

`Rack::AddressMunging` is a Rack middleware for automatic [e-mail addresses munging](https://en.wikipedia.org/wiki/Address_munging).

Once added to your middleware stack, `Rack::AddressMunging` will parse the body of any HTML response and mung it to obfuscate email addresses, in hope to prevent spambots to collect them too easily.

## Installation

`Rack::AddressMunging` is distributed as a gem and available on [rubygems.org](https://rubygems.org/gems/rack-address_munging) so you can add it to your `Gemfile` or install it manually with:

```ruby
gem install rack-address_munging
```

## Usage

To use the middleware with it's default configuration, just drop it in your middleware stack:

```ruby
# In config.ru or wherever your stack is defined
require 'rack/address_munging'

use Rack::AddressMunging
```

If you want to use another munging strategy, precise it as an argument:

```ruby
# In a Rails initializer
require 'rack/address_munging'

module YourRailsAppName
  class Application
    config.middleware.use Rack::AddressMunging, strategy: :hex
  end
end
```

## Supported Strategies

### `:Hex`

Replace email addresses and mailto href attributes values with an hexadecimal entities alternative.

    Input:  email@example.com
    Output: &#101;&#109;&#97;&#105;&#108;&#64;&#101;&#120;&#97;&#109;&#112;&#108;&#101;&#46;&#99;&#111;&#109;

`:Hex` is the default strategy.

### `:Rot13JS`

Replace email addresses and full mailto links with a `<script>` tag that will print it back into the page, based on a [ROT13](https://en.wikipedia.org/wiki/ROT13) version.

    Input:  email@example.com
    Output: <script type="text/javascript">document.write("rznvy(at)rknzcyr.pbz".replace(/(at)/, '@').replace(/[a-z]/gi,function(c){return String.fromCharCode((c<="Z"?90:122)>=(c=c.charCodeAt(0)+13)?c:c-26);});))</script>

For more informations about the exact behavior of each strategy, please refer to the [strategies specs data](https://github.com/notus-sh/rack-address_munging/blob/master/spec/data/strategy.yml).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/notus-sh/rack-address_munging>.
