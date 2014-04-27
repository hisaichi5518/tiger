# Tiger

Tiger is a mixin class to on/emit triggers (or hooks) that get called at some points you specify.

## Installation

Add this line to your application's Gemfile:

    gem 'tiger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiger

## Usage

```ruby
require 'tiger'

module YourModule
  include Tiger

  def self.hoge(*args)
    emit(:before_hoge, args)
    # ...
    emit(:after_hoge, args)
  end
end

YourModule.on(:before_hoge) do |args|
  puts "before hoge"
end

YourModule.on(:after_hoge) do |args|
  puts "after hoge"
end

YourModule.hoge({name: "hisaichi5518"})
#=> before hoge
#=> after hoge
```

```ruby
require 'tiger'

class YourClass
  include Tiger

  def self.hoge(*args)
    emit(:before_hoge, args)
    # ...
    emit(:after_hoge, args)
  end

  def fuga(*args)
    emit_all(:before_fuga, args)
    # ...
    emit_all(:after_fuga, args)
  end

end

YourClass.on(:before_hoge) do |args|
  puts "before hoge"
end

YourClass.on(:after_hoge) do |args|
  puts "after hoge"
end
YourClass.hoge({name: "hisaichi5518"})
#=> before hoge
#=> after hoge

YourClass.on(:before_fuga) do |args|
  puts "before fuga"
end
YourClass.on(:after_fuga) do |args|
  puts "after fuga"
end
your_class = YourClass.new
your_class.on :before_fuga do
  puts "before_fuga: only your_class instance"
end
your_class.on :after_fuga do
  puts "after_fuga: only your_class instance"
end

your_class.fuga({name: "hisaichi5518"})
#=> before fuga
#=> before_fuga: only your_class instance
#=> after fuga
#=> after_fuga: only your_class instance

your_class2 = YourClass.new
your_class2.fuga({name: "hisaichi5518"})
#=> before fuga
#=> after fuga
```

## Contributing

1. Fork it ( http://github.com/hisaichi5518/tiger-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
