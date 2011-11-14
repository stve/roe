require 'uri'
require 'faraday_middleware'

module Roe
  class Client
    attr_accessor :endpoint, :format
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(endpoint, format = :json)
      @endpoint = endpoint
      @format = format

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", Roe.options[key])
      end
    end

    def resolve(uri, options={})
      response = connection.get do |req|
        req.url endpoint_path, options.merge!(:url => uri, :format => format)
      end
      response.body.oembed || response.body
    end

    private
    def connection
      merged_options = connection_options.merge({
        :headers => {
          'Accept' => "application/#{format}",
          'User-Agent' => user_agent
        },
        :proxy => proxy,
        :url => endpoint_host
      })

      Faraday.new(merged_options) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Rashify
        case format.to_s
        when 'xml'
          builder.use Faraday::Response::ParseXml
        when 'json'
          builder.use Faraday::Response::ParseJson
        end
        builder.use Faraday::Response::RaiseError
        builder.adapter(adapter)
      end
    end

    def endpoint_path
      parsed_endpoint.path
    end

    def endpoint_host
      parsed_endpoint.scheme + '://' + parsed_endpoint.host
    end

    def parsed_endpoint
      @parsed_endpoint ||= URI.parse(@endpoint)
    end

  end
end