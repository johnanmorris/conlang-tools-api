require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test "word can't be created without a form" do
    word = Word.new(translation: "hello")
    assert_not word.valid?
    assert_includes word.errors, :form
  end

  test "word can't be created without a translation" do
    word = Word.new(form: "hallu")
    assert_not word.valid?
    assert_includes word.errors, :translation
  end

  test "create a valid word" do
    word = Word.new(form: "hallu", translation: "waterfall")
    assert word.valid?
    assert_not_nil word.form
    assert_not_nil word.translation
  end

  test "word belongs to a language" do
    word = Word.create!(form: "hallu", translation: "waterfall")
    language = Language.create!(name: "Sarano", description: "stuff")
    word.language = language
    assert word.save

    assert_equal word.language_id, language.id
    assert_includes language.words, word
    assert_respond_to word, :language
  end
end
