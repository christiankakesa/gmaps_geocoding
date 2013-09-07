# encoding: utf-8
require 'test/unit'
require_relative 'test_helper'
require 'gmaps_geocoding'

class GmapsGeocodingTest < Test::Unit::TestCase
  def test_config_default
    config = GmapsGeocoding::Config.new
    assert_not_nil config
    assert_equal false, config.valid?
  end

  def test_config_address_set
    config = GmapsGeocoding::Config.new({address: 'Tour Eiffel, IDF, Paris, France'})
    assert_not_nil config
    assert_equal true, config.valid?
  end

  def test_config_latlng_set
    config = GmapsGeocoding::Config.new({latlng: '40.714224,-73.961452'})
    assert_not_nil config
    assert_equal true, config.valid?
  end

  def test_config_address_latlng_set
    config = GmapsGeocoding::Config.new({address: 'Tour Eiffel, IDF, Paris, France', latlng: '40.714224,-73.961452'})
    assert_not_nil config
    assert_equal false, config.valid?
  end

  def test_config_url
    config = GmapsGeocoding::Config.new({url: 'http://fakeurl.com'})
    assert_equal 'http://fakeurl.com', config.url
  end

  def test_api_json_set
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    api = GmapsGeocoding::Api.new(opts)
    assert_not_nil api

    result_location = api.get_location
    assert_not_nil result_location
    assert_kind_of Hash, result_location
    assert_include result_location, 'results'

    result_latlng = api.get_finest_latlng(result_location['results'])
    assert_not_nil result_latlng
    assert_instance_of Array, result_latlng
  end

  def test_api_xml_set
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'xml'}
    api = GmapsGeocoding::Api.new(opts)
    assert_not_nil api

    result_location = api.get_location
    assert_not_nil result_location
    assert_kind_of Hash, result_location
    assert_include result_location, 'result'

    result_latlng = api.get_finest_latlng(result_location['result'])
    assert_not_nil result_latlng
    assert_instance_of Array, result_latlng
  end
end
