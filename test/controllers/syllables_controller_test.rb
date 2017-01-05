require 'test_helper'

class SyllablesControllerTest < ActionController::TestCase
  setup do
    @kelen_id = languages(:kelen).id
    @four_id = syllables(:four).id
    # API JSON setup
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  SYLLABLE_KEYS = %w( id language_id pattern )

  def compare_syllables(fixture, response)
    assert_equal SYLLABLE_KEYS, response.keys.sort
    SYLLABLE_KEYS.each do |key|
      assert_equal fixture[key], response[key]
    end
  end

  test "can get #index" do
    get :index, {language_id: @kelen_id}
    assert_response :success
  end

  test "#index returns json" do
    get :index, {language_id: @kelen_id}
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#index returns array of all Syllable objects in language" do
    get :index, {language_id: @kelen_id}
    body = JSON.parse(response.body)
    assert_instance_of Array, body
    assert_equal 2, body.length
  end

  test "objects in #index contain proper keys" do
    get :index, {language_id: @kelen_id}
    body = JSON.parse(response.body)
    assert_equal SYLLABLE_KEYS, body.map(&:keys).flatten.uniq.sort
  end

  test "#create adds a new syllable to the database" do
    syllable_data = {"pattern" => "consonant+vowel+nasal"}
    assert_difference('Syllable.count', 1) do
      post :create, {language_id: @kelen_id, "syllable": syllable_data}
    end

    assert_equal 3, languages(:kelen).syllables.size
    assert_response :created

    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)
    assert_instance_of Hash, body

    assert_equal 1, body.keys.length
    assert_equal "id", body.keys.first

    syllable_from_database = Syllable.find(body["id"])
    assert_equal syllable_data["pattern"], syllable_from_database.pattern
    assert_equal @kelen_id, syllable_from_database.language_id
  end

  test "#create doesn't add a new Syllable if the parameters are bad" do
    syllable_data = {"pattern" => ""}

    assert_no_difference('Syllable.count') do
      post :create, {language_id: @kelen_id, "syllable": syllable_data}
    end

    assert_response :bad_request
    assert_empty response.body
  end

  test "#update successfully modifies an existing Syllable object" do
    patch :update, {language_id: @kelen_id, id: @four_id, syllable: {"pattern": "nasal+vowel+stop"}}
    assert_equal "nasal+vowel+stop", Syllable.find(@four_id).pattern
  end

  test "#update should not allow empty string pattern" do
    patch :update, {language_id: @kelen_id, id: @four_id, syllable: {"pattern": ""}}
    assert_equal "nasal+stop+vowel", Syllable.find(@four_id).pattern
    assert_response :bad_request
    assert_empty response.body
  end

  test "#destroy should remove a Syllable from the database" do
    assert_difference('Syllable.count', -1) do
      delete :destroy, {language_id: @kelen_id, id: @four_id}
      assert_raises ActiveRecord::RecordNotFound do
        Syllable.find(@four_id)
      end
    end
    assert_response :no_content
  end
end
