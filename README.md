# Myflamegraph

Flamegraph support for Rails apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'myflamegraph'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install myflamegraph

## Usage

For example, to profile OrdersController#index, OrdersController#create :

```ruby
class OrdersController < ApplicationController
   # add this line
   ffff :index, :create

   def index
     # ...
   end

   def create
     # ...
   end
end
```

Run those methods anyway, then find flamegraph in tmp dir. (run `Myflamegraph.tmp` to figure out location of your tmp dir)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
