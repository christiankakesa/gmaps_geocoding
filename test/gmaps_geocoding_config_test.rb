require_relative '../lib/gmaps_geocoding'
require_relative 'test_helper'

# Main test class
class GmapsGeocodingConfigTest < Test::Unit::TestCase
  def test_config_default
    config = GmapsGeocoding::Config.new
    assert_not_nil config

    assert_equal false, config.valid?
    assert_equal true,  config.json_format?
    assert_equal false, config.xml_format?
  end

  def test_config_default_address
    config = GmapsGeocoding::Config.new
    assert_not_nil config

    assert_equal true, config.url.size > 0
    assert_equal 'json', config.output
    assert_nil config.address
  end

  def test_config_default_optional
    config = GmapsGeocoding::Config.new
    assert_not_nil config
    assert_nil config.latlng
    assert_nil config.components
    assert_equal 'false', config.sensor
    assert_nil config.bounds
    assert_nil config.language
    assert_nil config.region
  end

  def test_config_address_set
    config = GmapsGeocoding::Config.new(address: 'Tour Eiffel, IDF, Paris, France')
    assert_not_nil config
    assert_equal true, config.valid?
  end

  def test_config_latlng_set
    config = GmapsGeocoding::Config.new(latlng: '40.714224,-73.961452')
    assert_not_nil config
    assert_equal true, config.valid?
  end

  def test_config_address_latlng_set
    config = GmapsGeocoding::Config.new(address: 'Tour Eiffel, IDF, Paris, France', latlng: '40.714224,-73.961452')
    assert_not_nil config
    assert_equal false, config.valid?
  end

  def test_config_url
    config = GmapsGeocoding::Config.new(url: 'http://fakeurl.com')
    assert_equal 'http://fakeurl.com', config.url
  end
end
