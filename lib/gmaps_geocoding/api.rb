# encoding: utf-8

module GmapsGeocoding
  class Api
    attr_reader :config

    def initialize(opts = {})
      @config = Config.new(opts)
    end

    def get_location
      get_gmaps_data
    end

    private
    def get_gmaps_data
      begin
        if @config.valid?
          rest_client = retrieve_geocoding_data
          result = case @config.is_output_json?
                     when true
                       GmapsGeocoding.from_json(rest_client.to_s)
                     else
                       # Xml parser
                       GmapsGeocoding.from_xml(rest_client.to_s)
                   end
          return result
        end
      rescue => e
        puts "[error: gmaps_geocoding]: #{e}"
        nil
      end
    end

    def build_url_query
      query = {}
      query[:address]    = @config.address    if @config.address
      query[:latlng]     = @config.latlng     if @config.latlng
      query[:components] = @config.components if @config.components
      query[:sensor]     = @config.sensor     if @config.sensor
      query[:bounds]     = @config.bounds     if @config.bounds
      query[:language]   = @config.language   if @config.language
      query[:region]     = @config.region     if @config.region
      url = "#{@config.url}/#{@config.output}"
      {url: url, query: query}
    end

    def retrieve_geocoding_data
      require 'rest-client'
      data = build_url_query
      RestClient.get data[:url], params: data[:query]
    end
  end

  def self.from_json(json)
    require 'yajl/json_gem'
    Yajl::Parser.parse(json)
  end

  def self.from_xml(xml)
    require 'nori'
    n = Nori.new(parser: :nokogiri).parse(xml)
    if n.include?('GeocodeResponse')
      n = n['GeocodeResponse']
    else
      n = {'status' => 'UNKNOWN_ERROR'}
    end
    n
  end
end
