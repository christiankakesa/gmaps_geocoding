require 'logger'
require 'ox'
require 'oj'
require 'rest-client'

# Gmaps geocoding module
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
      @logger = opts.delete(:logger)
      unless @logger
        @logger = Logger.new(STDERR) do |l|
          l.progname = 'gmaps_geocoding'.freeze
          l.level = $DEBUG ? Logger::DEBUG : Logger::INFO
        end
      end
      @config = GmapsGeocoding::Config.new(opts)
      Oj.default_options = Oj.default_options.merge(bigdecimal_load: :float, float_precision: 7)
    end

    # Return a Ruby Hash object of the Google Maps Geocoding Service response
    #
    # {https://developers.google.com/maps/documentation/geocoding/ Google Maps Geocoding Service documentation}.
    #
    # @example
    #  # json output example
    #  opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    #  api = GmapsGeocoding::Api.new(opts)
    #  result = api.location
    #  # xml output example
    #  opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'xml'}
    #  api = GmapsGeocoding::Api.new(opts)
    #  result = api.location
    #
    def location
      fail 'Invalid configuration parameters check the Google Geocoding API documentation'.freeze unless @config.valid?
      rest_client = retrieve_geocoding_data
      case @config.json_format?
      when true
        json_to_hash(rest_client)
      else
        xml_to_hash(rest_client)
      end
    rescue => e
      @logger.error e
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
    #  data = api.location
    #  if data.include?('status') && data['status'].eql?('OK') # or more simple : if data.include?('results')
    #    return finest_latlng(data['results']) # output : [2.291018, 48.857269]
    #  end
    #
    # @param data [Array] The json#results or xml#result array from {#location} method
    # @return [Array] array contains latitude and longitude of the location
    # rubocop:disable Metrics/AbcSize
    def finest_latlng(data)
      result = retrieve_finest_location(data)
      return [result['ROOFTOP'][:lng], result['ROOFTOP'][:lat]] if result.include?('ROOFTOP'.freeze)
      return [result['RANGE_INTERPOLATED'][:lng], result['RANGE_INTERPOLATED'][:lat]] if result.include?('RANGE_INTERPOLATED'.freeze)
      return [result['GEOMETRIC_CENTER'][:lng], result['GEOMETRIC_CENTER'][:lat]] if result.include?('GEOMETRIC_CENTER'.freeze)
      [result['APPROXIMATE'][:lng], result['APPROXIMATE'][:lat]]
    rescue
      [0.0, 0.0].freeze
    end
    # rubocop:enable Metrics/AbcSize

    private

    def retrieve_finest_location(data)
      result = {}
      tmp_data = data
      tmp_data = [tmp_data] unless tmp_data.is_a?(Array)
      tmp_data.each do |d|
        result[d['geometry']['location_type']] = { lng: d['geometry']['location']['lng'].to_f,
                                                   lat: d['geometry']['location']['lat'].to_f }
      end
      result
    end

    def build_url_query
      query_params = {}
      VALID_QUERY_PARAMS.each do |k|
        val = @config.send(k)
        query_params[k] = val if val
      end
      { url: "#{@config.url}/#{@config.output}", params: query_params }.freeze
    end

    def retrieve_geocoding_data
      data = build_url_query
      RestClient.get data[:url], params: data[:params]
    end

    def json_to_hash(json_str)
      Oj.load(json_str)
    end

    def xml_to_hash(xml_str)
      xml = Ox.parse(xml_str)
      r = xml_node_to_ruby(xml)
      if r.include?('GeocodeResponse'.freeze)
        r['GeocodeResponse']
      else
        { status: 'UNKNOWN_ERROR'.freeze }
      end
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def xml_node_to_ruby(ox)
      return unless ox.respond_to?(:nodes)
      result = {}
      ox.nodes.each do |d|
        next unless d.respond_to?(:nodes)
        if d.nodes[0].is_a?(Ox::Element)
          if result.include?(d.value)
            unless result[d.value].is_a?(Array)
              result[d.value] = [result[d.value]]
            end
            result[d.value] << xml_node_to_ruby(d)
          else
            result[d.value] = xml_node_to_ruby(d)
          end
        elsif result.include?(d.value)
          unless result[d.value].is_a?(Array)
            result[d.value] = [result[d.value]]
          end
          result[d.value] << d.nodes[0]
        else
          result[d.value] = d.nodes[0]
        end
      end
      result
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
