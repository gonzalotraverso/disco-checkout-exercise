# DiscoCheckout

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/disco_checkout`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'disco_checkout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install disco_checkout

## Usage

Run:

    $ rake test

### Assignment:

You are the lead programmer for a small chain of supermarkets. You are required to make a simple cashier function that adds products to a cart and displays the total price.

You have the following test products registered:
| Product code | Name         | Price  |
|--------------|--------------|--------|
| GR1          | Green tea    | £3.11  |
| SR1          | Strawberries | £5.00  |
| CF1          | Coffee       | £11.23 |

### Special conditions:

● The CEO is a big fan of buy-one-get-one-free offers and of green tea. He wants us to add a rule to do this.

● The COO, though, likes low prices and wants people buying strawberries to get a price discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to £4.50

● The CTO is a coffee addict. If you buy 3 or more coffees, the price of all coffees should drop to two thirds of the original price.

Our check-out can scan items in any order, and because the CEO and COO change their minds often, it needs to be flexible regarding our pricing rules.

The interface to our checkout looks like this (shown in ruby):
```ruby
co = Checkout.new(pricing_rules) co.scan(item)
co.scan(item)
price = co.total
```

Implement a checkout system that fulfills these requirements.

Test data:

Basket: GR1,SR1,GR1,GR1,CF1 
Total price expected: ​£22.45

Basket: GR1,GR1
Total price expected: ​£3.11

Basket: SR1,SR1,GR1,SR1 
Total price expected:​ £16.61

Basket: GR1,CF1,SR1,CF1,CF1 
Total price expected:​ £30.57

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/disco_checkout. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

