require 'spec_helper'

describe Roe do
  after do
    Roe.reset
  end

  use_vcr_cassette "roe", :record => :new_episodes

  describe ".resolve" do
    it 'returns a Hashie::Rash' do
      data = Roe.resolve('http://www.hulu.com/watch/240024/family-guy-episode-vi-its-a-trap')
      data.should be_kind_of(Hashie::Rash)
    end

    it 'returns oembed data' do
      data = Roe.resolve('http://www.hulu.com/watch/240024/family-guy-episode-vi-its-a-trap')
      data.embed_url.should be
    end

    it 'returns nil when no data found' do
      data = Roe.resolve('http://m.cnn.com/')
      data.should be_nil
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Roe.adapter.should == Roe::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Roe.adapter = :typhoeus
      Roe.adapter.should == :typhoeus
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Roe.user_agent.should == Roe::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Roe.user_agent = 'Custom User Agent'
      Roe.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do
    Roe::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Roe.configure do |config|
          config.send("#{key}=", key)
          Roe.send(key).should == key
        end
      end
    end
  end
end