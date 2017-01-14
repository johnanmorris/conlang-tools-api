require 'test_helper'

class PhonemesControllerTest < ActionController::TestCase

  setup do
    # API JSON setup
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  PHONEME_KEYS = %w( back consonant front high id ipa low manner place syllabic voice)

  test "can get phonemes#index" do
    get :index
    assert_response :success
  end

  test "phonemes#index returns json" do
    get :index
    assert_match 'application/json', response.header['Content-Type']
  end

  test "phonemes#index returns a hash of all phonemes" do
    get :index
    body = JSON.parse(response.body)
    assert_instance_of Hash, body
    assert_equal 1, body.keys.length
    assert_match "phonemes", body.keys.first
    assert_instance_of Array, body["phonemes"]
    assert_equal 5, body["phonemes"].length
  end

  test "objects in #index contain proper keys" do
    get :index
    body = JSON.parse(response.body)
    objects = body["phonemes"]
    assert_equal PHONEME_KEYS, objects.map(&:keys).flatten.uniq.sort
  end
end
