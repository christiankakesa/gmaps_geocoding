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

    def get_finest_latlng
      data = get_gmaps_data
      if !data.nil? && (data.include?('results') || data.include?('result'))
        result = data['results']||data['result']
        get_best_location_from_gmaps(result)
      else
        nil
      end
    end

    private
    def get_gmaps_data
      begin
        if @config.valid?
          rest_client = retrieve_geocoding_data
          result = case @config.is_json_format?
                     when true
                       GmapsGeocoding.from_json(rest_client.to_s)
                     else
                       GmapsGeocoding.from_xml(rest_client.to_s)
                   end
          return result
        end
      rescue => e
        puts "[error: gmaps_geocoding]: #{e}"
      end
      nil
    end

    # Get the best location for an address based on Goole Maps Geocoder "location_type"
    #
    # location_type stores additional data about the specified location. The following values are currently supported:
    #   google.maps.GeocoderLocationType.ROOFTOP            indicates that the returned result reflects a precise geocode.
    #   google.maps.GeocoderLocationType.RANGE_INTERPOLATED indicates that the returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.
    #   google.maps.GeocoderLocationType.GEOMETRIC_CENTER   indicates that the returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).
    #   google.maps.GeocoderLocationType.APPROXIMATE        indicates that the returned result is approximate.
    #
    def get_best_location_from_gmaps(data)
      result = {}
      data.each do |d|
        result["#{d['geometry']['location_type']}"] = {lng: d['geometry']['location']['lng'].to_f,
                                                       lat: d['geometry']['location']['lat'].to_f}
      end
      if result.include?('ROOFTOP')
        [result['ROOFTOP'][:lng], result['ROOFTOP'][:lat]]
      elsif result.include?('RANGE_INTERPOLATED')
        [result['RANGE_INTERPOLATED'][:lng], result['RANGE_INTERPOLATED'][:lat]]
      elsif result.include?('GEOMETRIC_CENTER')
        [result['GEOMETRIC_CENTER'][:lng], result['GEOMETRIC_CENTER'][:lat]]
      else
        [result['APPROXIMATE'][:lng], result['APPROXIMATE'][:lat]]
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
      data = build_url_query()
      RestClient.get data[:url], params: data[:query]
    end
  end

  class << self
    def from_json(json)
      require 'yajl/json_gem'
      Yajl::Parser.parse(json)
    end

    def from_xml(xml)
      require 'nori'
      result = Nori.new(parser: :nokogiri).parse(xml)
      if result.include?('GeocodeResponse')
        result['GeocodeResponse']
      else
        {status: 'UNKNOWN_ERROR'}
      end
    end
  end
end
