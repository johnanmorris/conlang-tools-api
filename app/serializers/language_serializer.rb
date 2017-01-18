class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :phonemes, embed: :ids, embed_in_root: true
  has_many :words, embed: :ids, embed_in_root: true
end
