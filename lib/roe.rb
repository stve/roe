require 'roe/configuration'
require 'roe/client'

module Roe
  extend Configuration
  extend self

  @providers = [
    { :pattern => /youtube\.com/, :service => 'http://www.youtube.com/oembed' },
    { :pattern => /(flic\.kr|(www\.)?flickr.com)/, :service => 'http://www.flickr.com/services/oembed' },
    { :pattern => /viddler\.com/, :service => 'http://lab.viddler.com/services/oembed/' },
    { :pattern => /qik\.com/, :service => 'http://qik.com/api/oembed.json' },
    { :pattern => /revision3\.com/, :service => 'http://revision3.com/api/oembed/' },
    { :pattern => /hulu\.com/, :service => 'http://www.hulu.com/api/oembed' },
    { :pattern => /vimeo\.com/, :service => 'http://vimeo.com/api/oembed.json' },
    { :pattern => /opera\.com/, :service => 'http://my.opera.com/service/oembed' },
    { :pattern => /skitch\.com/, :service => 'http://skitch.com/oembed' },
    { :pattern => /instagr\.am/, :service => 'http://api.instagram.com/oembed' }
  ]

  def resolve(url, options = {})
    @providers.each do |provider|
      return Client.new(provider[:service]).resolve(url, options) if match?(provider[:pattern], url)
    end

    nil
  end

  private
  def match?(pattern, url)
    pattern.match(url)
  end

end
