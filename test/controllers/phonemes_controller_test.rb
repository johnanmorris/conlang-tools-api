require 'test_helper'

class PhonemesControllerTest < ActionController::TestCase

  setup do
    @kelen_id = languages(:kelen).id
    # API JSON setup
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  PHONEME_KEYS = %w( back consonant front high ipa low manner place voice syllabic )

  def compare_phonemes(fixture, response)
    assert_equal PHONEME_KEYS, response.keys.sort
    PHONEME_KEYS.each do |key|
      assert_equal fixture[key], response[key]
    end
  end

  test "can get #index" do
    get :index, {language_id: @kelen_id }
    assert_response :success
  end

  test "#index returns json" do
    get :index, {language_id: @kelen_id }
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#index returns an Array of all Phoneme objects belonging to a language" do
    get :index, {language_id: @kelen_id }
    body = JSON.parse(response.body)
    assert_instance_of Array, body
    assert_equal 3, body.length
  end

  test "objects in #index contain proper keys with nil values removed" do
    get :index, {language_id: @kelen_id }
    body = JSON.parse(response.body)
    body_keys = body.map(&:keys).flatten.uniq
    body_keys.each do |key|
      assert_includes PHONEME_KEYS, key
    end
  end
end
