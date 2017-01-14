require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  setup do
    @kelen_id = languages(:kelen).id
    @word_id = words(:house).id
    # API JSON setup
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  WORD_KEYS = %w(form id language_id translation)

  test "can get words#index" do
    get :index, {language_id: @kelen_id}
    assert_response :success
  end

  test "words#index returns json" do
    get :index, {language_id: @kelen_id}
    assert_match 'application/json', response.header['Content-Type']
  end

  test "words#index returns array of all words in language" do
    get :index, {language_id: @kelen_id}
    body = JSON.parse(response.body)
    assert_instance_of Hash, body
    assert_equal 1, body.keys.length
    assert_equal "words", body.keys.first
    assert_equal 2, body["words"].length
  end

  test "objects in words#index contain proper keys" do
    get :index, {language_id: @kelen_id}
    body = JSON.parse(response.body)
    objects = body["words"]
    assert_equal WORD_KEYS, objects.map(&:keys).flatten.uniq.sort
  end

  test "words#create adds a new word to the database" do
    word_data = {"form" => "pathan", "translation" => "worry"}
    assert_difference('Word.count', 1) do
      post :create, {language_id: @kelen_id, "word": word_data}
    end

    assert_equal 3, languages(:kelen).words.size
    assert_response :created

    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)
    object = body["word"]
    assert_instance_of Hash, body

    assert_equal 4, object.keys.length

    word_from_database = Word.find(object["id"])
    assert_equal word_data["form"], word_from_database.form
    assert_equal word_data["translation"], word_from_database.translation
    assert_equal @kelen_id, word_from_database.language_id
  end

  test "words#create doesn't add a new Word if parameters are bad" do
    word_data = {"form" => "", "translation" => "hi"}

    assert_no_difference('Word.count') do
      post :create, {language_id: @kelen_id, "word": word_data}
    end

    assert_response :bad_request
    assert_empty response.body
  end

  test "words#update successfully modifies an existing Word" do
    patch :update, {language_id: @kelen_id, id: @word_id, word: {"form": "astera"}}
    assert_equal "astera", Word.find(@word_id).form
  end

  test "words#update should not allow empty form" do
    patch :update, {language_id: @kelen_id, id: @word_id, word: {"form": ""}}
    assert_equal "jamara", Word.find(@word_id).form
    assert_response :bad_request
    assert_empty response.body
  end

  test "words#update should not allow empty translation" do
    patch :update, {language_id: @kelen_id, id: @word_id, word: {"translation": ""}}
    assert_equal "house", Word.find(@word_id).translation
    assert_response :bad_request
    assert_empty response.body
  end

  test "words#destroy should remove a Syllable from the database" do
    assert_difference('Word.count', -1) do
      delete :destroy, {language_id: @kelen_id, id: @word_id}
      assert_raises ActiveRecord::RecordNotFound do
        Word.find(@word_id)
      end
    end
    assert_response :no_content
  end
end
