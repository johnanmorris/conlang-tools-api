require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test "Cannot create a language without a name" do
    language = Language.new(description: "this is a conlang")
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
    s_ph = phonemes(:s)
    q_ph = phonemes(:q)
    p_ph = phonemes(:p)
    assert_equal 3, kelen.phonemes.length
    assert_includes kelen.phoneme_ids, s_ph.id
    assert_includes kelen.phoneme_ids, q_ph.id
    assert_includes kelen.phoneme_ids, p_ph.id
    assert_equal 1, esperanto.phonemes.length
    assert_includes esperanto.phoneme_ids, s_ph.id
    assert_respond_to kelen, :phonemes
    assert_respond_to esperanto, :phonemes
  end
end
