# encoding: utf-8

module GmapsGeocoding
  # Google Maps Geocoding Service abstraction class
  #
  # @example
  #  opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
  #  api = GmapsGeocoding::Api.new(opts)
  #
  class Api
    attr_reader :config

    def initialize(opts = {})
      @config = GmapsGeocoding::Config.new(opts)
    end

    # Return a Ruby Hash object of the Google Maps Geocoding Service response
    #
    # {https://developers.google.com/maps/documentation/geocoding/ Google Maps Geocoding Service documentation}.
    #
    # @example
    #  # json output example
    #  opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    #  api = GmapsGeocoding::Api.new(opts)
    #  result = api.get_location
    #  # xml output example
    #  opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'xml'}
    #  api = GmapsGeocoding::Api.new(opts)
    #  result = api.get_location
    #
    def get_location
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

    # Get the best latlng for an address based on Google Maps Geocoder "location_type"
    #
    # location_type stores additional data about the specified location. The following values are currently supported:
    #   google.maps.GeocoderLocationType.ROOFTOP            indicates that the returned result reflects a precise geocode.
    #   google.maps.GeocoderLocationType.RANGE_INTERPOLATED indicates that the returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.
    #   google.maps.GeocoderLocationType.GEOMETRIC_CENTER   indicates that the returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).
    #   google.maps.GeocoderLocationType.APPROXIMATE        indicates that the returned result is approximate.
    #
    # @example
    #  # json output example
    #  opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    #  api = GmapsGeocoding::Api.new(opts)
    #  data = api.get_location
    #  if data.include?('status') && data['status'].eql?('OK') # or more simple : if data.include?('results')
    #    return get_finest_latlng(data['results']) # output : [2.291018, 48.857269]
    #  end
    #
    # @param data_result [Array] The json#results or xml#result array from {#get_location} method
    # @return [Array] array contains latitude and longitude of the location
    def get_finest_latlng(data_result)
      tmp_result = {}
      data = data_result
      if data.kind_of?(Array)
        data.each do |d|
          tmp_result["#{d['geometry']['location_type']}"] = {lng: d['geometry']['location']['lng'].to_f,
                                                             lat: d['geometry']['location']['lat'].to_f}
        end
      else
        tmp_result["#{data['geometry']['location_type']}"] = {lng: data['geometry']['location']['lng'].to_f,
                                                              lat: data['geometry']['location']['lat'].to_f}
      end
      if tmp_result.include?('ROOFTOP')
        [tmp_result['ROOFTOP'][:lng], tmp_result['ROOFTOP'][:lat]]
      elsif tmp_result.include?('RANGE_INTERPOLATED')
        [tmp_result['RANGE_INTERPOLATED'][:lng], tmp_result['RANGE_INTERPOLATED'][:lat]]
      elsif tmp_result.include?('GEOMETRIC_CENTER')
        [tmp_result['GEOMETRIC_CENTER'][:lng], tmp_result['GEOMETRIC_CENTER'][:lat]]
      else
        [tmp_result['APPROXIMATE'][:lng], tmp_result['APPROXIMATE'][:lat]]
      end
    end

    private
    def build_url_query
      query = {}
      query[:address] = @config.address if @config.address
      query[:latlng] = @config.latlng if @config.latlng
      query[:components] = @config.components if @config.components
      query[:sensor] = @config.sensor if @config.sensor
      query[:bounds] = @config.bounds if @config.bounds
      query[:language] = @config.language if @config.language
      query[:region] = @config.region if @config.region
      url = "#{@config.url}/#{@config.output}"
      {url: url, query: query}
    end

    def retrieve_geocoding_data
      require 'rest-client'
      data = build_url_query
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
      result = Nori.new.parse(xml)
      if result.include?('GeocodeResponse')
        result['GeocodeResponse']
      else
        {status: 'UNKNOWN_ERROR'}
      end
    end
  end
end
