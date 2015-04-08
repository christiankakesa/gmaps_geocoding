
require_relative '../lib/gmaps_geocoding'
require_relative 'test_helper'

# Main test class
class GmapsGeocodingApiTest < Test::Unit::TestCase
  def test_api_json_set
    opts = { address: 'Tour Eiffel, Paris, IDF, France', output: 'json' }
    api = GmapsGeocoding::Api.new(opts)
    assert_not_nil api

    result_location = api.location
    assert_not_nil result_location
    assert_kind_of Hash, result_location
    assert_include result_location, 'results'

    result_latlng = api.finest_latlng(result_location['results'])
    assert_not_nil result_latlng
    assert_instance_of Array, result_latlng
  end

  def test_api_xml_set
    opts = { address: 'Tour Eiffel, Paris, IDF, France', output: 'xml' }
    api = GmapsGeocoding::Api.new(opts)
    assert_not_nil api

    result_location = api.location
    assert_not_nil result_location
    assert_kind_of Hash, result_location
    assert_include result_location, 'result'

    result_latlng = api.finest_latlng(result_location['result'])
    assert_not_nil result_latlng
    assert_instance_of Array, result_latlng
  end
end
