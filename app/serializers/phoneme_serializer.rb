class PhonemeSerializer < ActiveModel::Serializer
  attributes :id, :ipa, :voice, :place, :manner, :consonant, :syllabic, :high, :front, :low, :back
  has_many :languages, embed: :ids, embed_in_root: true
end
