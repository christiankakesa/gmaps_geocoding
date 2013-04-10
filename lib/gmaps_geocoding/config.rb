# encoding: utf-8

module GmapsGeocoding
  class Config
    attr_reader :options

    def initialize(opts = {})
      @options = {url: 'https://maps.googleapis.com/maps/api/geocode'}
      @options[:output]     = ENV['GOOGLE_MAPS_GEOCODING_OUTPUT']     || opts[:output]     || 'json'
      @options[:address]    = ENV['GOOGLE_MAPS_GEOCODING_ADDRESS']    || opts[:address]    || ''
      @options[:latlng]     = ENV['GOOGLE_MAPS_GEOCODING_LATLNG']     || opts[:latlng]     || ''
      @options[:components] = ENV['GOOGLE_MAPS_GEOCODING_COMPONENTS'] || opts[:components] || ''
      @options[:sensor]     = ENV['GOOGLE_MAPS_GEOCODING_SENSOR']     || opts[:sensor]     || 'false'
      @options[:bounds]     = ENV['GOOGLE_MAPS_GEOCODING_BOUNDS']     || opts[:bounds]     || ''
      @options[:language]   = ENV['GOOGLE_MAPS_GEOCODING_LANGUAGE']   || opts[:language]   || ''
      @options[:region]     = ENV['GOOGLE_MAPS_GEOCODING_REGION']     || opts[:region]     || ''
      @options.merge!(opts).reject!{|_, v| v.to_s.length == 0 }
    end

    def url
      @options[:url]
    end

    def output
      @options[:output]
    end

    def address
      @options[:address]
    end

    def latlng
      @options[:latlng]
    end

    def components
      @options[:components]
    end

    def sensor
      @options[:sensor]
    end

    def bounds
      @options[:bounds]
    end

    def language
      @options[:language]
    end

    def region
      @options[:region]
    end

    def valid?
      return is_query_valid? &&
          is_output_param_valid?
    end

    def is_json_format?
      'json'.eql?(output)
    end

    def is_xml_format?
      'xml'.eql?(output)
    end

    private
    def is_query_valid?
      (@options[:address].to_s.length > 0 && @options[:latlng].to_s.length == 0) ||
          (@options[:address].to_s.length == 0 && @options[:latlng].to_s.length > 0)
    end

    def is_output_param_valid?
      ['json', 'xml'].include?(output)
    end
  end
end
