require 'test_helper'

class SyllableTest < ActiveSupport::TestCase
  test "syllable can't be created without a pattern" do
    syllable = Syllable.new
    assert_not syllable.valid?
    assert_includes syllable.errors, :pattern
  end

  test "create valid syllable" do
    syllable = syllables(:one)
    assert syllable.valid?
    assert_not_nil syllable.pattern
  end

  test "syllable belongs to a Language" do
    syllable = Syllable.create!(pattern: "stop+liquid+vowel")
    language = Language.create!(name: "Sarano", description: "something")
    syllable.language = language
    assert syllable.save

    assert_equal syllable.language_id, language.id
    assert_includes language.syllables, syllable
    assert_respond_to syllable, :language
  end
end
