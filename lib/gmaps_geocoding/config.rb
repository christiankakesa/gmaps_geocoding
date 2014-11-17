# encoding: utf-8

module GmapsGeocoding
  # Configuration class for GmapsGeocoding API.
  class Config
    def initialize(opts = {})
      @options = { url: 'https://maps.googleapis.com/maps/api/geocode' }
      @options[:output] = ENV['GOOGLE_MAPS_GEOCODING_OUTPUT'] || opts[:output] || 'json'
      @options[:address] = ENV['GOOGLE_MAPS_GEOCODING_ADDRESS'] || opts[:address] || ''
      @options[:latlng] = ENV['GOOGLE_MAPS_GEOCODING_LATLNG'] || opts[:latlng] || ''
      @options[:components] = ENV['GOOGLE_MAPS_GEOCODING_COMPONENTS'] || opts[:components] || ''
      @options[:sensor] = ENV['GOOGLE_MAPS_GEOCODING_SENSOR'] || opts[:sensor] || 'false'
      @options[:bounds] = ENV['GOOGLE_MAPS_GEOCODING_BOUNDS'] || opts[:bounds] || ''
      @options[:language] = ENV['GOOGLE_MAPS_GEOCODING_LANGUAGE'] || opts[:language] || ''
      @options[:region] = ENV['GOOGLE_MAPS_GEOCODING_REGION'] || opts[:region] || ''
      @options.merge!(opts).reject! { |_, v| v.length == 0 }
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
      is_query_valid? && is_output_param_valid?
    end

    # Check if the output format of the query is set to _json_
    #
    # @return [true, false] Return _true_ or _false_
    def is_json_format?
      'json'.eql?(output)
    end

    # Check if the output format of the query is set to _xml_
    #
    # @return [true, false] Return _true_ or _false_
    def is_xml_format?
      'xml'.eql?(output)
    end

    private
    # Check if the query is valid
    #
    # According to the specifications: {https://developers.google.com/maps/documentation/geocoding/#GeocodingRequests}
    def is_query_valid?
      (@options.include?(:address) && !@options.include?(:latlng)) ||
          (!@options.include?(:address) && @options.include?(:latlng)) ||
          @options.include?(:components)
    end

    # Check if the output format is valid
    #
    # According to the specifications: {https://developers.google.com/maps/documentation/geocoding/#GeocodingResponses}
    def is_output_param_valid?
      %w(json xml).include?(output)
    end
  end
end
