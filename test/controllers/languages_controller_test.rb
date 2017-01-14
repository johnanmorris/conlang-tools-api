require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  setup do

    @kelen_id = languages(:kelen).id

    # API JSON setup
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  LANGUAGE_KEYS = %w( description id name phoneme_ids phonemes )

  test "can get languages#index" do
    get :index
    assert_response :success
  end

  test "languages#index returns json" do
    get :index
    assert_match 'application/json', response.header['Content-Type']
  end

  test "languages#index returns a Hash of all languages" do
    get :index
    body = JSON.parse(response.body)
    assert_instance_of Hash, body
    assert_equal 1, body.keys.length
    assert_equal "languages", body.keys[0]
    assert_equal 3, body["languages"].length
  end

  test "objects in languages#index contain proper keys" do
    get :index
    body = JSON.parse(response.body)
    obj_array = body["languages"]
    assert_equal LANGUAGE_KEYS, obj_array.map(&:keys).flatten.uniq.sort
  end

  test "languages#show an existing language" do
    get :show, {id: languages(:kelen).id }
    assert_response :success
    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)
    objects = body["language"]
    assert_instance_of Hash, body
    assert_instance_of Hash, objects
  end

  test "languages#show returns empty response if the id doesn't exist" do
    lang_id = 123456

    assert_raises ActiveRecord::RecordNotFound do
      Language.find(lang_id)
    end

    get :show, {id: lang_id}
    assert_response :not_found
    assert_empty response.body
  end

  test "languages#create adds a new Language" do
    language_data = {"name" => "Araina", "description" => "why"}
    assert_difference('Language.count', 1) do
      post :create, {"language": language_data}
    end

    assert_response :created

    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)
    object = body["language"]
    assert_instance_of Hash, body
    assert_instance_of Hash, object

    assert_equal 5, object.keys.length
    assert_equal "id", object.keys.first

    lang_from_database = Language.find(object["id"])
    assert_equal language_data["name"], lang_from_database.name
  end

  test "languages#create doesn't add a new Language if the parameters are bad" do
    language_data = {"description" => "stuff"}

    assert_no_difference('Language.count') do
      post :create, {"language": language_data}
    end

    assert_response :bad_request
    assert_empty response.body
  end

  test "languages#update successfully modifies an existing Language object" do
    patch :update, {id: @kelen_id, language: {name: "Kele"}}
    assert_equal "Kele", Language.find(@kelen_id).name
  end

  test "languages#update should not allow empty string name" do
    patch :update, {id: @kelen_id, language: {name: ""}}
    assert_equal "Kelen", Language.find(@kelen_id).name
    assert_response :bad_request
    assert_empty response.body
  end

  test "languages#destroy should remove a Language from the database" do
    assert_difference('Language.count', -1) do
      delete :destroy, {id: @kelen_id}
      assert_raises ActiveRecord::RecordNotFound do
        Language.find(@kelen_id)
      end
    end
    assert_response :no_content
  end
end
