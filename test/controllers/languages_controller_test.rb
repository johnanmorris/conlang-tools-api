require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  setup do

    @kelen_id = languages(:kelen).id

    # API JSON setup
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  LANGUAGE_KEYS = %w( description id name )

  def compare_languages(fixture, response)
    assert_equal LANGUAGE_KEYS, response.keys.sort
    LANGUAGE_KEYS.each do |key|
      assert_equal fixture[key], response[key]
    end
  end

  test "can get #index" do
    get :index
    assert_response :success
  end

  test "#index returns json" do
    get :index
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#index returns an Array of all Language objects" do
    get :index
    body = JSON.parse(response.body)
    assert_instance_of Array, body
    assert_equal 3, body.length
  end

  test "objects in #index contain proper keys" do
    get :index
    body = JSON.parse(response.body)
    assert_equal LANGUAGE_KEYS, body.map(&:keys).flatten.uniq.sort
  end

  test "#show an existing language" do
    get :show, {id: languages(:kelen).id }
    assert_response :success
    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)
    assert_instance_of Hash, body
    compare_languages(languages(:kelen), body)
  end

  test "return empty response if the id doesn't exist" do
    lang_id = 123456

    assert_raises ActiveRecord::RecordNotFound do
      Language.find(lang_id)
    end

    get :show, {id: lang_id}
    assert_response :not_found
    assert_empty response.body
  end

  test "#create adds a new Language" do
    language_data = {"name" => "Araina", "description" => "why"}
    assert_difference('Language.count', 1) do
      post :create, {"language": language_data}
    end

    assert_response :created

    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)
    assert_instance_of Hash, body

    assert_equal 1, body.keys.length
    assert_equal "id", body.keys.first

    lang_from_database = Language.find(body["id"])
    assert_equal language_data["name"], lang_from_database.name
  end

  test "#create doesn't add a new Language if the parameters are bad" do
    language_data = {"description" => "stuff"}

    assert_no_difference('Language.count') do
      post :create, {"language": language_data}
    end

    assert_response :bad_request
    assert_empty response.body
  end

  test "#update successfully modifies an existing Language object" do
    patch :update, {id: @kelen_id, language: {name: "Kele"}}
    assert_equal "Kele", Language.find(@kelen_id).name
  end

  test "#update should not allow empty string name" do
    patch :update, {id: @kelen_id, language: {name: ""}}
    assert_equal "Kelen", Language.find(@kelen_id).name
    assert_response :bad_request
    assert_empty response.body
  end

  test "#destroy should remove a Language from the database" do
    assert_difference('Language.count', -1) do
      delete :destroy, {id: @kelen_id}
      assert_raises ActiveRecord::RecordNotFound do
        Language.find(@kelen_id)
      end
    end
  end
end
