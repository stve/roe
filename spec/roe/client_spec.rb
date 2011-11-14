require 'spec_helper'

describe Roe::Client do

  use_vcr_cassette "client", :record => :new_episodes

  describe '.new' do
    it 'initializes with a url' do
      client = Roe::Client.new('http://www.youtube.com/oembed')
      client.endpoint.should eq('http://www.youtube.com/oembed')
    end

    it 'defaults the format to json' do
      client = Roe::Client.new('http://www.youtube.com/oembed')
      client.format.should eq(:json)
    end

    it 'accepts an optional format argument' do
      client = Roe::Client.new('http://www.youtube.com/oembed', :xml)
      client.format.should eq(:xml)
    end
  end

  describe '#resolve' do
    it 'returns a Hashie::Rash' do
      client = Roe::Client.new('http://vimeo.com/api/oembed.json')
      client.resolve('http://vimeo.com/7100569').should be_kind_of(Hashie::Rash)
    end

    it 'returns oembed data using json format' do
      client = Roe::Client.new('http://www.hulu.com/api/oembed.json')
      data = client.resolve('http://www.hulu.com/watch/20807/late-night-with-conan-obrien-wed-may-21-2008')
      data.embed_url.should be
    end

    it 'returns oembed data using xml format' do
      client = Roe::Client.new('http://www.hulu.com/api/oembed.xml', :xml)
      data = client.resolve('http://www.hulu.com/watch/20807/late-night-with-conan-obrien-wed-may-21-2008')
      data.embed_url.should be
    end

    it 'raises a Faraday error when passing invalid arguments' do
      client = Roe::Client.new('http://vimeo.com/api/oembed.json')
      lambda {
        client.resolve('123')
      }.should raise_error
    end
  end
end