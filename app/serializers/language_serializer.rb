class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :phonemes
end
