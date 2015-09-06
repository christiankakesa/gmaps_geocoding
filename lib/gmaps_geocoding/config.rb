# Gmaps geocoding module
module GmapsGeocoding
  # Configuration valid keys
  VALID_KEYS = [:url, :output, :key, :address, :latlng, :components, :sensor, :bounds, :language, :region, :place_id, :result_type, :location_type].freeze

  # Valid query parameters
  VALID_QUERY_PARAMS = VALID_KEYS - [:url, :output].freeze

  # Configuration class for GmapsGeocoding API.
  class Config
    # All valid keys is stored in instance attribute
    attr_accessor(*VALID_KEYS)

    # Default configuration values
    DEFAULT_CONFIG = {
      url: 'https://maps.googleapis.com/maps/api/geocode'.freeze,
      output: 'json'.freeze,
      sensor: 'false'.freeze
    }.freeze

    def initialize(opts = {})
      opts = DEFAULT_CONFIG.merge(opts)
      VALID_KEYS.each do |k, _|
        next unless VALID_KEYS.include?(k)
        val = ENV["GOOGLE_MAPS_GEOCODING_#{k.to_s.upcase}"] || opts.delete(k)
        send("#{k}=", val) if val
      end
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
      'json'.freeze.eql?(output)
    end

    # Check if the output format of the query is set to _xml_
    #
    # @return [true, false] Return _true_ or _false_
    def xml_format?
      'xml'.freeze.eql?(output)
    end

    private

    # Check if the query is valid
    #
    # According to the specifications: {https://developers.google.com/maps/documentation/geocoding/#GeocodingRequests}
    def query_valid?
      (address && latlng.nil?) ||
        (latlng && address.nil?) ||
        !components.nil?
    end

    # Check if the output format is valid
    #
    # According to the specifications: {https://developers.google.com/maps/documentation/geocoding/#GeocodingResponses}
    def output_param_valid?
      %w(json xml).include?(output)
    end
  end
end
