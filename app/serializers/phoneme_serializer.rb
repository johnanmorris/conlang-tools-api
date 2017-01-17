class PhonemeSerializer < ActiveModel::Serializer
  attributes :id, :ipa, :voice, :place, :manner, :consonant, :syllabic, :high, :front, :low, :back
end
