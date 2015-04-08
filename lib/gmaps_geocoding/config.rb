# Gmaps geocoding module
module GmapsGeocoding
  # Configuration class for GmapsGeocoding API.
  class Config
    # Configuration valid keys
    VALID_KEYS = [:url, :output, :address, :latlng, :components, :sensor, :bounds, :language, :region].freeze

    # Default configuration values
    DEFAULT_CONFIG = {
      url: 'https://maps.googleapis.com/maps/api/geocode',
      output: 'json',
      sensor: 'false'
    }.freeze

    def initialize(opts = {})
      @options = {}
      @options.merge!(DEFAULT_CONFIG)
      opts.each do |k, _|
        next unless VALID_KEYS.include?(k)
        val = if k.eql?(:url)
                opts.delete(k)
              else
                ENV["GOOGLE_MAPS_GEOCODING_#{k.to_s.upcase}"] || opts.delete(k)
              end
        @options[k] = val if val
      end
    end

    # URL of the Google Maps Geocoding Service
    #
    # @return [String] URL of the Google Maps Geocoding Service
    def url
      @options[:url]
    end

    # Output format of the Google Maps Geocoding Service
    #
    # @return [String] Output format of the Google Maps Geocoding Service. Only _xml_ or _json_ formats are available
    def output
      @options[:output]
    end

    # The address that you want to geocode
    #
    # @return [String] The address that you want to geocode.
    def address
      @options[:address]
    end

    # The textual latitude/longitude value for which you wish to obtain the closest, human-readable address
    #
    # @example
    #  "40.714224,-73.961452"
    #
    # @return [String] The textual latitude/longitude value for which you wish to obtain the closest, human-readable address
    def latlng
      @options[:latlng]
    end

    # A component filter for which you wish to obtain a geocode
    #
    # {https://developers.google.com/maps/documentation/geocoding/#ComponentFiltering}
    # @return [String] A component filter for which you wish to obtain a geocode
    def components
      @options[:components]
    end

    # Indicates whether or not the geocoding request comes from a device with a location sensor.
    #
    # @return [String] Indicates whether or not the geocoding request comes from a device with a location sensor. Must be either "true" or "false".
    def sensor
      @options[:sensor]
    end

    # The bounding box of the viewport within which to bias geocode results more prominently
    #
    # {https://developers.google.com/maps/documentation/geocoding/#Viewports}
    # @return [String] The bounding box of the viewport within which to bias geocode results more prominently
    def bounds
      @options[:bounds]
    end

    # The language in which to return results
    #
    # @return [String] The language in which to return results. {https://developers.google.com/maps/faq#languagesupport Supported languages}.
    def language
      @options[:language]
    end

    # The region code, specified as a ccTLD ("top-level domain") two-character value
    #
    # {https://developers.google.com/maps/documentation/geocoding/#RegionCodes}
    # @return [String] The region code, specified as a ccTLD ("top-level domain") two-character value
    def region
      @options[:region]
    end

    # Check if the configuration object is valid
    #
    # @return [true, false] Return _true_ or _false_
    def valid?
      query_valid? && output_param_valid?
    end

    # Check if the output format of the query is set to _json_
    #
    # @return [true, false] Return _true_ or _false_
    def json_format?
      'json'.eql?(output)
    end

    # Check if the output format of the query is set to _xml_
    #
    # @return [true, false] Return _true_ or _false_
    def xml_format?
      'xml'.eql?(output)
    end

    private

    # Check if the query is valid
    #
    # According to the specifications: {https://developers.google.com/maps/documentation/geocoding/#GeocodingRequests}
    def query_valid?
      (@options.include?(:address) && !@options.include?(:latlng)) ||
        (!@options.include?(:address) && @options.include?(:latlng)) ||
        @options.include?(:components)
    end

    # Check if the output format is valid
    #
    # According to the specifications: {https://developers.google.com/maps/documentation/geocoding/#GeocodingResponses}
    def output_param_valid?
      %w(json xml).include?(output)
    end
  end
end
