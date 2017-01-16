class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :phoneme_ids
  has_many :phonemes
  has_many :words
end
