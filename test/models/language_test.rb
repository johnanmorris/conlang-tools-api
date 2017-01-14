require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test "Cannot create a language without a name" do
    language = Language.new(description: "this is a conlang")
    assert_not language.valid?
    assert_includes language.errors, :name
  end

  test "Cannot create a language with a nil name" do
    language = Language.new(name: nil, description: "ceci n'est pas une pipe")
    assert_not language.valid?
    assert_includes language.errors, :name
  end

  test "Cannot create a languge with an empty string name" do
    language = Language.new(name: "", description: "something")
    assert_not language.valid?
    assert_includes language.errors, :name
  end

  test "Can create language without a description" do
    language = Language.new(name: "Zompist")
    assert language.valid?
    assert_nil language.description
  end

  test "Create valid language" do
    language = languages(:esperanto)
    assert language.valid?
    assert_not_nil language.name
    assert_not_nil language.description
  end

  test "Language belongs to a User" do
    skip("haven't implemented User model yet")
    language = Language.create!(name: "Sarano", description: "something")
    user = User.create!(username: "testing", email: "test@test.com", uid: 124, provider: "google")
    language.user = user
    assert language.save
    assert_equal language.user_id, user.id
    assert_includes user.languages, language
    assert_respond_to language, :user
  end

  test "Language can have many phonemes" do
    kelen = languages(:kelen)
    esperanto = languages(:esperanto)
    p_ph = phonemes(:p)
    b_ph = phonemes(:b_cap)
    s_ph = phonemes(:s)
    i_ph = phonemes(:i)

    assert_equal 3, kelen.phonemes.size
    assert_includes kelen.phoneme_ids, s_ph.id
    assert_includes kelen.phoneme_ids, b_ph.id
    assert_includes kelen.phoneme_ids, p_ph.id

    assert_equal 2, esperanto.phonemes.size
    assert_includes esperanto.phoneme_ids, s_ph.id
    assert_includes esperanto.phoneme_ids, i_ph.id

    assert_respond_to kelen, :phonemes
    assert_respond_to esperanto, :phonemes
  end

  test "a language can have no phonemes" do
    laadan = languages(:laadan)
    assert laadan.phonemes.empty?
    assert laadan.valid?
  end

  test "a language can have many words" do
    esperanto = languages(:esperanto)
    akvo = words(:water)
    stelo = words(:star)
    assert_equal 2, esperanto.words.size
    assert_includes esperanto.word_ids, akvo.id
    assert_includes esperanto.word_ids, stelo.id
    assert_respond_to esperanto, :words
  end
end
