require 'test_helper'

class PhonemeTest < ActiveSupport::TestCase
  test "cannot create a phoneme without its IPA" do
    no_ipa = Phoneme.new(voice: true, consonant: true, place: "dental", manner: "fricative")
    assert_not no_ipa.valid?
    assert_includes no_ipa.errors, :ipa
  end

  test "cannot create a phoneme without a consonant value" do
    no_cons = Phoneme.new(ipa: "r", place: "alveolar", manner: "trill", voice: true)
    assert_not no_cons.valid?
    assert_includes no_cons.errors, :consonant
  end

  test "cannot create a phoneme without a voice value" do
    no_voice = Phoneme.new(ipa: "r", consonant: true, place: "alveolar", manner: "trill")
    assert_not no_voice.valid?
    assert_includes no_voice.errors, :voice
  end

  test "create a valid phoneme with only ipa, consonant, and voice" do
    minimum = Phoneme.create!(ipa: "s", consonant: true, voice: false)
    assert minimum.valid?
    assert minimum.save
    assert_not_nil minimum.ipa
    assert_not_nil minimum.consonant
    assert_not_nil minimum.voice
  end

  test "phoneme can have many languages" do
    s_ph = phonemes(:s)

    kelen = languages(:kelen)
    esperanto = languages(:esperanto)

    assert_equal 2, s_ph.languages.size
    assert_includes s_ph.language_ids, kelen.id
    assert_includes s_ph.language_ids, esperanto.id

    assert_respond_to s_ph, :languages
  end

  test "a phoneme can have no languages" do
    eth = phonemes(:eth)

    assert eth.languages.empty?
    assert eth.valid?
  end
end
