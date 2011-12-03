# Roe

Roe is a ruby oEmbed client.

## Installation

    (sudo) gem install roe


## Documentation

[http://rdoc.info/gems/yql-query](http://rdoc.info/gems/roe)

## Usage

Roe exposes a method `resolve` for accessing oEmbed data:

```ruby
Roe.resolve('http://twitpic.com/7745l9')
# => <Hashie::Rash version="1.0" type="photo" width=240 height=160 >
```

You can pass an options hash (optional) to refine your query:

```ruby
Roe.resolve('http://twitpic.com/7745l9', :maxheight => 240)
```

Under the hood, Roe uses Faraday as well as MultiJson to parse the provider
responses.  It then converts the response hash into a Hashie::Rash.  You can
specify an http client by configuring Roe:

```ruby
Roe.configure do |config|
  config.adapter = :typhoeus
  config.user_agent = 'oEmbed Client'
  config.proxy = ENV['http_proxy']
end
```

## Supported Providers

  * YouTube
  * Flickr
  * Viddler
  * Qik
  * Hulu
  * Revision 3
  * Vimeo
  * Opera
  * Skitch
  * Instagram

## <a name="ci"></a>Build Status
[![Build Status](https://secure.travis-ci.org/spagalloco/roe.png)][ci]

[ci]: http://travis-ci.org/spagalloco/roe

## <a name="dependencies"></a>Dependency Status
[![Dependency Status](https://gemnasium.com/spagalloco/roe.png)][gemnasium]

[gemnasium]: https://gemnasium.com/spagalloco/roe

## TODO

* add the ability to dynamically add new services
* support for more providers

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Steve Agalloco. See LICENSE for details.