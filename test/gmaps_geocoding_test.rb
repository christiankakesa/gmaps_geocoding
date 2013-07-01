# encoding: utf-8
require 'test/unit'
require 'gmaps_geocoding'

class GmapsGeocodingTest < Test::Unit::TestCase
  def test_config_default
    config = GmapsGeocoding::Config.new
    assert_not_nil config
    assert_equal false, config.valid?
    assert_equal 3, config.options.length
  end

  def test_config_address_set
    config = GmapsGeocoding::Config.new({address: 'Tour Eiffel, IDF, Paris, France'})
    assert_not_nil config
    assert_equal true, config.valid?
    assert_equal 4, config.options.length
  end

   def test_config_latlng_set
    config = GmapsGeocoding::Config.new({latlng: '40.714224,-73.961452'})
    assert_not_nil config
    assert_equal true, config.valid?
    assert_equal 4, config.options.length
  end

  def test_config_address_latlng_set
    config = GmapsGeocoding::Config.new({address: 'Tour Eiffel, IDF, Paris, France', latlng: '40.714224,-73.961452'})
    assert_not_nil config
    assert_equal false, config.valid?
    assert_equal 5, config.options.length
  end

  def test_api_json_set
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'json'}
    api = GmapsGeocoding::Api.new(opts)
    result_location = api.get_location
    result_latlng =  api.get_finest_latlng
    assert_not_nil api
    assert_not_nil result_location
    assert_kind_of Object, result_location
    assert_not_nil result_latlng
    assert_instance_of Array, result_latlng
    assert_equal 4, api.config.options.length
  end

  def test_api_xml_set
    opts = {address: 'Tour Eiffel, Paris, IDF, France', output: 'xml'}
    api = GmapsGeocoding::Api.new(opts)
    result_location = api.get_location
    result_latlng =  api.get_finest_latlng
    assert_not_nil api
    assert_not_nil result_location
    assert_kind_of Object, result_location
    assert_not_nil result_latlng
    assert_instance_of Array, result_latlng
    assert_equal 4, api.config.options.length
  end
end
